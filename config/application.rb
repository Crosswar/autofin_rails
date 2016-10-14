require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require "csv"
require "iconv"

Bundler.require(*Rails.groups)

module AutofinRails
  class Application < Rails::Application
  	config.i18n.default_locale = :'ptBR'
  end
end
