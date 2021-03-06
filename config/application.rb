require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Questionnaries
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # config.action_dispatch.default_headers = {
    #   'X-Frame-Options' => 'SAMEORIGIN',
    #   'X-XSS-Protection' => '1; mode=block',
    #   'X-Content-Type-Options' => 'nosniff'
    # }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
