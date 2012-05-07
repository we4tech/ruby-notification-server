require 'spec_helper'

describe NotificationServer::Configuration do

  describe '._load_config_file' do
    it 'should load configuration file' do
      NotificationServer::Configuration.send(:_config).should be
    end
  end

  describe 'configuration fields' do
    subject {
      NotificationServer::Configuration
        .send(:define_method, :_file_join, proc { 'spec/config/notification_server.yml' })
      NotificationServer::Configuration
    }

    its(:hostname) { should match 'localhost' }
    its(:port) { should == 2211 }
    its(:forever) { should be_true }
    its(:secure) { should be_false }

    context 'when not secure' do
      its(:script_path) { should match 'http://localhost:2211/nowjs/now.js' }
    end

    context 'when secure' do
      before { NotificationServer::Configuration.should_receive(:secure).and_return(true) }
      its(:script_path) { should match 'https://localhost:2211/nowjs/now.js' }
    end
  end

end