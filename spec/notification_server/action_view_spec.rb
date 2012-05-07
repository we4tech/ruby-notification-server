require 'spec_helper'
require 'notification_server/action_view/script_helper'

class TestHelper
  include NotificationServer::ActionView::ScriptHelper
end

describe NotificationServer::ActionView::ScriptHelper do

  describe '#javascript_include_notification_server' do
    it 'should generate script tag with server javascript' do
      TestHelper.new.javascript_include_notification_server
        .should match "<script type='text/javascript'  src=\"http://localhost:2211/nowjs/now.js\"></script>"
    end
  end

  describe '#javascript_include_async_notification_server' do
    it 'should generate script tag' do
      TestHelper.new.javascript_include_async_notification_server
        .should match /jQuery\('head'\)\.append/
    end
  end

end