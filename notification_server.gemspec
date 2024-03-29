# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "notification_server"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["nhm tanveer hossain khan", "nafi ul karim"]
  s.date = "2012-05-15"
  s.description = "Node notification server integration library for ruby project"
  s.email = ["hasan@somewherein.net"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "lib/generators/notification_server/config/config_generator.rb",
    "lib/generators/notification_server/config/templates/config.yml",
    "lib/notification_server.rb",
    "lib/notification_server/action_view.rb",
    "lib/notification_server/action_view/script_helper.rb",
    "lib/notification_server/configuration.rb",
    "lib/notification_server/engine.rb",
    "lib/tasks/server.rake"
  ]
  s.homepage = "https://github.com/we4tech/ruby-notification-server"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "An extension for integrating node 'notification-server' with ruby project"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

