require File.expand_path('../boot', __FILE__)

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Cocoaheads
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # routes the exceptions to the route file
    config.exceptions_app = self.routes

    # default social networkds
    COCOAHEADS_SOCIAL_WEB           = "http://cocoaheads.com.br"
    COCOAHEADS_SOCIAL_INSTAGRAM     = "http://instagram.com/cocoaheadsbr/"
    COCOAHEADS_SOCIAL_FACEBOOK      = "https://www.facebook.com/CocoaHeadsBrasil/"
    COCOAHEADS_SOCIAL_TWITTER       = "https://twitter.com/cocoaheadsbr/"
    COCOAHEADS_SOCIAL_GITHUB        = "https://github.com/cocoaheadsbr/"
    COCOAHEADS_SOCIAL_YOUTUBE       = "https://www.youtube.com/channel/UCxN-_poBEXynC7YPE_394LQ"
    COCOAHEADS_SOCIAL_ITUNES        = "https://itunes.apple.com/br/podcast/cocoaheads-brasil/id879833520"
  end
end
