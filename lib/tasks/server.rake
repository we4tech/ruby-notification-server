require 'fileutils'

module NotificationServer
  module Tasks
    class CommandBuilder
      def initialize
        @cmds = []
      end

      def <<(cmd)
        @cmds << cmd
        self
      end

      def build
        @cmds.flatten.join(' ')
      end
    end

    class Server
      class << self

        def start(_env)
          _config = config(_env)
          _argv   = []
          _argv << "-p #{_config['port']}"

          if _config['hostname'].present?
            _argv << "-H #{_config['hostname']}"
          end

          if cmd_exist?
            if 'true' == _config['forever'].to_s
              %w(notification_server.log notification_server_error.log forever.log)
                .each { |log_file| `touch log/#{log_file}` }

              _cb = CommandBuilder.new
              _cb << "/usr/bin/env forever -v -a" <<
                       "-o $PWD/log/notification_server.log" <<
                       "-e $PWD/log/notification_server_error.log" <<
                       "-l $PWD/log/forever.log" <<
                       "`which notification-server`" <<
                       _argv
              _pid = create_pid(spawn(_cb.build), _env)
              STDOUT.puts "Process id - #{_pid}"
            else
              _pid = create_pid(spawn("/usr/bin/env notification-server #{_argv.join(' ')}"), _env)
              STDOUT.puts "Process id - #{_pid}"
            end
          else
            STDERR.puts "`notification-server` command not found, please install `npm install -g notification-server`"
          end
        end

        def stop(_env)
          _config = config(_env)
          _forever = 'true' == _config['forever'].to_s

          existing_pid = read_pid(_env)

          if !_forever && existing_pid.present?
            output = `kill #{existing_pid}`
            STDOUT.puts output
            STDOUT.puts 'Notification server stopped.'
            remove_pid(_env)
          elsif _forever
            spawn("/usr/bin/env forever stop `which notification-server`")
            remove_pid(_env)
            STDOUT.puts 'Notification server stopped.'
          else
            STDERR.puts "No such existing notification server process found"
          end
        end

        def remove_pid(_env)
          FileUtils.remove pid_file(_env)
        end

        def create_pid(_pid, _env)
          File.open(pid_file(_env), 'w') do |f|
            f.puts _pid
          end

          _pid
        end

        def read_pid(_env)
          if File.exist?(pid_file(_env))
            File.read(pid_file(_env))
          else
            nil
          end
        end

        def pid_file(_env)
          pids_path = Rails.root.join('tmp', 'pids')
          FileUtils.makedirs(pids_path)

          File.join(pids_path, "notification_server_#{_env}.pid")
        end

        def cmd_exist?
          _output = `which notification-server`
          _output.present?
        end

        def config_exist?
          File.exist? config_file
        end

        def config(_env)
          if config_exist?
            yaml = YAML.load(File.read(config_file))
            if valid_config? yaml[_env]
              yaml[_env]
            else
              raise "notification-server >> `port` is not defined in #{config_file}"
            end
          else
            raise "notification-server >> config not found, please run `rails g notification_server:config`"
          end
        end

        def config_file
          Rails.root.join('config', 'notification_server.yml')
        end

        def valid_config?(_config)
          _config.is_a?(Hash) && _config.keys.include?('port')
        end
      end
    end
  end
end

namespace :notification_server do
  desc 'Start notification server'
  task :start => :environment do
    NotificationServer::Tasks::Server.start(Rails.env)
  end

  desc 'Stop notification server'
  task :stop => :environment do
    NotificationServer::Tasks::Server.stop(Rails.env)
  end

  desc 'Restart notification server'
  task :restart => [:stop, :start] do
    puts 'Restarted notification server.'
  end
end