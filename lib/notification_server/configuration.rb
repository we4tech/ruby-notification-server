module NotificationServer
  class Configuration
    class << self

      def hostname; _config['hostname'] end
      def port; _config['port'] end
      def forever; _config['forever'] end
      def secure; _config['secure'] end
      def script_path; "#{secure ? 'https' : 'http'}://#{hostname}:#{port}/nowjs/now.js" end

      private
        def _config
          if defined?(@@_config).nil?
            _load_config_file(_file_join('config', 'notification_server.yml'))
          else
            @@_config
          end
        end

        def _file_join(*paths)
          if defined?(Rails)
            Rails.root.join(*paths)
          else
            File.join(paths)
          end
        end

        def _load_config_file(config_file)
          if File.exist?(config_file)
            yaml = YAML.load(File.read(config_file))
            @@_config = yaml[_config_env]
          else
            puts "#{config_file} not found. please execute `rails g notification_server:config`"
            @@_config = {}
          end
        end

        def _config_env
          if defined?(Rails)
            Rails.env
          else
            'test'
          end
        end
    end
  end
end