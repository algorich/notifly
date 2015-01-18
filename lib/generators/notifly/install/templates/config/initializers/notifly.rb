Notifly.setup do |config|
  # Define how many notifications per page.
  config.per_page = 10

  # Define the time interval in miliseconfs between requests to check notifications.
  config.timeout = 10000

  # Define the notifly icon from font-awesome-rails
  config.icon = 'bell'

  # Define the notifly icon size
  config.icon_size = '2x'

  # Define your mailer sender
  config.mailer_sender = 'change-me-at-config-initializers-notifly@exemple.com'
end