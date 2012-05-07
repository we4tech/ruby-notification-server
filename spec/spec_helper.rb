# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require "rubygems"
require "bundler"
Bundler.require

require 'rspec/autorun'
require 'notification_server'

RSpec.configure do |config|
  config.mock_with :rspec
end

class NotificationServer::Configuration
  class << self
    def _file_join(*args); 'spec/config/notification_server.yml' end
  end
end

