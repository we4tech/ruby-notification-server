module NotificationServer
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_config
        copy_file 'config.yml', 'config/notification_server.yml'
      end

    end
  end
end