require 'rubygems'
require 'rake'
require 'rdoc/task'
require 'bundler'
require 'rake/testtask'
require 'rspec/core/rake_task'

task :default => 'spec:unit' do
end

namespace :spec do
  desc "Run acceptance specs"
  RSpec::Core::RakeTask.new('unit') do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end

task :environment do
end

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name    = "notification_server"
    gem.summary = "An extension for integrating node 'notification-server' with ruby project"
    gem.homepage = 'https://github.com/we4tech/ruby-notification-server'
    gem.description = 'Node notification server integration library for ruby project'
    gem.email   = ["hasan@somewherein.net"]
    gem.authors = ["nhm tanveer hossain khan", "nafi ul karim"]
    gem.files   = Dir["{lib}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue
  puts "Jeweler or dependency not available."
end
