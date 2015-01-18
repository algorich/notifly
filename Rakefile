# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name        = 'notifly'
  gem.authors     = ['Pedro Passalini', 'Rafael Carvalho']
  gem.email       = ['henrique.passalini@gmail.com', 'rafael@algorich.com.br']
  gem.homepage    = 'https://github.com/algorich/notifly'
  gem.summary     = 'A full notification system'
  gem.description = 'This project intend to offer a full notification system, back and front-end.'
  gem.license     = 'MIT'
  gem.files = Dir['{app,config,db,lib,vendor}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
end
Jeweler::RubygemsDotOrgTasks.new

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks