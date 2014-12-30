# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: notifly 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "notifly"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Pedro Passalini", "Rafael Carvalho"]
  s.date = "2014-12-30"
  s.description = "This project intend to offer a full notification system, back and front-end."
  s.email = ["henrique.passalini@gmail.com", "rafael@algorich.com.br"]
  s.executables = ["rails"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "app/assets/javascripts/notifly.js",
    "app/assets/javascripts/notifly/get_notifications.js.erb",
    "app/assets/javascripts/notifly/more_notifications.js.erb",
    "app/assets/javascripts/notifly/read_notifications.js.erb",
    "app/assets/javascripts/notifly/seen_notifications.js.erb",
    "app/assets/javascripts/notifly_dropdown.js",
    "app/assets/stylesheets/notifly.css",
    "app/assets/stylesheets/notifly/layout.css",
    "app/controllers/notifly/application_controller.rb",
    "app/controllers/notifly/notifications_controller.rb",
    "app/helpers/notifly/view_helper.rb",
    "app/mailers/notifly/notification_mailer.rb",
    "app/models/notifly/notification.rb",
    "app/views/notifly/layouts/_actions.html.erb",
    "app/views/notifly/layouts/_counter.html.erb",
    "app/views/notifly/layouts/_empty.html.erb",
    "app/views/notifly/layouts/_index.html.erb",
    "app/views/notifly/layouts/_notification.html.erb",
    "app/views/notifly/layouts/_notifly.html.erb",
    "app/views/notifly/notification_mailer/notifly.html.erb",
    "app/views/notifly/notifications/index.js.erb",
    "app/views/notifly/notifications/read.js.erb",
    "app/views/notifly/notifications/seen.js.erb",
    "app/views/notifly/notifications/toggle_read.js.erb",
    "app/views/notifly/templates/mails/_default.html.erb",
    "app/views/notifly/templates/notifications/_default.html.erb",
    "config/locales/en.yml",
    "config/routes.rb",
    "db/migrate/20141103170528_create_notifly_notifications.rb",
    "db/migrate/20141104150224_add_data_to_notification.rb",
    "db/migrate/20141117193436_add_seen_to_notifly_notification.rb",
    "db/migrate/20141125165636_add_mail_to_notifly_notifications.rb",
    "db/migrate/20141212122918_add_kind_to_notifly_notification.rb",
    "lib/generators/notifly/install/install_generator.rb",
    "lib/generators/notifly/install/templates/config/initializers/notifly.rb",
    "lib/generators/notifly/install/utils.rb",
    "lib/generators/notifly/views/views_generator.rb",
    "lib/notifly.rb",
    "lib/notifly/engine.rb",
    "lib/notifly/models/base.rb",
    "lib/notifly/models/flyable.rb",
    "lib/notifly/models/notifiable.rb",
    "lib/notifly/models/options/fly.rb",
    "lib/notifly/railtie.rb",
    "lib/tasks/notifly_tasks.rake",
    "vendor/assets/javascripts/tinycon.js",
    "vendor/assets/javascripts/twitter/bootstrap/dropdown.js",
    "vendor/assets/stylesheets/twitter/bootstrap.css"
  ]
  s.homepage = "https://github.com/algorich/notifly"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "A full notification system"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 4"])
      s.add_runtime_dependency(%q<jquery-rails>, ["< 5", ">= 3.0"])
      s.add_runtime_dependency(%q<font-awesome-rails>, ["~> 4.2.0"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<pry-rails>, [">= 0"])
      s.add_development_dependency(%q<pry-rescue>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<better_errors>, [">= 0"])
      s.add_development_dependency(%q<binding_of_caller>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 4"])
      s.add_dependency(%q<jquery-rails>, ["< 5", ">= 3.0"])
      s.add_dependency(%q<font-awesome-rails>, ["~> 4.2.0"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<pry-rails>, [">= 0"])
      s.add_dependency(%q<pry-rescue>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<better_errors>, [">= 0"])
      s.add_dependency(%q<binding_of_caller>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 4"])
    s.add_dependency(%q<jquery-rails>, ["< 5", ">= 3.0"])
    s.add_dependency(%q<font-awesome-rails>, ["~> 4.2.0"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<pry-rails>, [">= 0"])
    s.add_dependency(%q<pry-rescue>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<better_errors>, [">= 0"])
    s.add_dependency(%q<binding_of_caller>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

