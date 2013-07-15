require 'torquespec'
require 'torquebox-core'
require 'capybara'
require 'net/http'


TorqueSpec.local {
  require 'capybara/dsl'
  require 'capybara/json'
  require 'akephalos'
  require 'json'


  Capybara.register_driver :akephalos do |app|
    Capybara::Driver::Akephalos.new(app, :browser => :firefox_3)
  end
#  Capybara.default_driver = :rack_test_json
#  Capybara.javascript_driver = :akephalos
  Capybara.default_driver = :akephalos
  Capybara.app_host = "http://localhost:8080"
  Capybara.run_server = false

  module JsonApi

    def get_json(path)
      uri = URI("http://localhost:8080#{path}")
      handle_response Net::HTTP.get_response(uri)
    end

    def handle_response(response)
      while response.code == "302" and not (new_location = response["location"]).nil?
        response = Net::HTTP.get_response(URI.parse(new_location))
      end

      values = {}
      values[:status_code] = response.code
      values[:status_message] = response.message
      values[:raw] = response.body
      values[:object] = JSON.parse response.body if response.code == '200'
      values


    end

    def post_json(path, parameters)
      uri = URI.parse("http://localhost:8080#{path}")
      handle_response Net::HTTP.post_form(uri, parameters)
    end
  end

  RSpec.configure do |config|
    config.include Capybara
    config.include Capybara::Json
    config.include JsonApi
    config.after do
      Capybara.reset_sessions!
    end
  end
}

ENV["RACK_ENV"] = "testing"

Dir["./spec/helper/**/*.rb"].sort.each {|f| require f}
