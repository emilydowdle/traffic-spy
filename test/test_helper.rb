ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'
require 'pry'
require 'tilt/erb'

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}
Capybara.app = TrafficSpy::Server

class Minitest::Test
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    TrafficSpy::Server
  end

  def standard_payload
    { "payload"=> "{  \"url\":\"http://jumpstartlab.com/blog\",
                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                      \"respondedIn\":37,
                      \"referredBy\":\"http://jumpstartlab.com\",
                      \"requestType\":\"GET\",
                      \"parameters\":[],
                      \"eventName\": \"socialLogin\",
                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                      \"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",
                      \"ip\":\"63.29.38.211\" }"}
  end

  def create_source_and_payload
    source = Source.create({ identifier: "jumpstartlab",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                             "requestedAt"=>"2013-02-16 21:38:28 -0700",
                             "respondedIn"=>37,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
                             "parameters"=>[],
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })
  end

  def create_second_source_and_payload
    source = Source.create({ identifier: "google",
                             rootUrl:    "http://google.com" })

    source.payloads.create({ "url"=>"http://google.com/analytics",
                             "requestedAt"=>"2013-02-17 21:38:28 -0700",
                             "respondedIn"=>40,
                             "referredBy"=>"http://google.com",
                             "requestType"=>"GET",
                             "parameters"=>[],
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })
  end

end

class FeatureTest < Minitest::Test
  include Capybara::DSL
end
