require_relative "boot"

require "rails/all"


Bundler.require(*Rails.groups)

module Manyoukadai
  class Application < Rails::Application
    
    config.load_defaults 6.1

    config.generators do |g|
      g.test_framework :rspec,
                       model_specs: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
    end
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
