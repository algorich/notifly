Capybara.javascript_driver = :poltergeist

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.run_server = true
Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, :Port => port)
end

RSpec.configure do |c|
  c.before(:each) do |example|
    Capybara.current_driver = example.metadata[:driver] || :poltergeist
  end

  c.before(:suite) { Notifly.websocket = true if ENV['WEBSOCKET'] == 'true' }
end