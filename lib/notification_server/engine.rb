require 'rails'
require 'notification_server/action_view'

module NotificationServer
  class Engine < Rails::Engine
    engine_name 'notification_server'

    initializer 'notification_server.helpers' do |app|
      ActiveSupport.on_load :action_controller do |ac|
        ac.helper NotificationServer::ActionView
      end
    end
  end
end