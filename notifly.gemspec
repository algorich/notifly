$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'notifly/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'notifly'
  s.version     = Notifly::VERSION
  s.authors     = ['TODO: Your name']
  s.email       = ['TODO: Your email']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Notifly.'
  s.description = 'TODO: Description of Notifly.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.1.6'
  s.add_dependency 'jquery-rails', ['>= 3.0', '< 5']
  s.add_dependency 'jquery-ui-rails', '~> 5.0'
  s.add_dependency 'kaminari', '~> 0.16.1'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails', '~> 3.1.0'
  s.add_development_dependency 'capybara', '~> 2.4.4'
  s.add_development_dependency 'poltergeist', '~> 1.5.1'
  s.add_development_dependency 'shoulda-matchers', '~> 2.7.0'
end
