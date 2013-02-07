# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SampleApp::Application.initialize!

# ActionMailer defaults
ActionMailer::Base.default_url_options = { host: 'localhost:3000' }
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.bgrantez.me",
  :port                 => 587,
  :domain               => 'bgrantez.me',
  :user_name            => 'rails@bgrantez.me',
  :password             => 'Test1ngR41ls',
  :authentication       => 'plain',
  :enable_starttls_auto => true ,
  :openssl_verify_mode  => 'none' }
