Rails.application.configure do
  # ... other configurations ...

  config.action_mailer.default_url_options = { host: 'your-production-domain.com' }
  
  # Configure production email settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'your-production-domain.com',
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true
  }
end