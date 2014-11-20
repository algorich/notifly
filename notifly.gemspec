$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'notifly/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'notifly'
  s.version     = Notifly::VERSION
  s.authors     = ['Pedro Passalini', 'Rafael Carvalho']
  s.email       = ['henrique.passalini@gmail.com', 'rafael@algorich.com.br']
  s.homepage    = 'https://github.com/algorich/notifly'
  s.summary     = 'A full notification system'
  s.description = 'This project intend to offer a full notification system, back and front-end.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 4'
  s.add_dependency 'jquery-rails', ['>= 3.0', '< 5']
  s.add_dependency 'kaminari', '~> 0.16.1'
  s.add_dependency 'font-awesome-rails', '~> 4.2.0'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails', '~> 3.1.0'
  s.add_development_dependency 'capybara', '~> 2.4.4'
  s.add_development_dependency 'poltergeist', '~> 1.5.1'
  s.add_development_dependency 'shoulda-matchers', '~> 2.7.0'
end
