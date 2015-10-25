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
  include Capybara::DSL

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    TrafficSpy::Server
  end

  def source_find(standard_payload)
    source = Source.find_by(identifier: params[:identifier])
  end

  def standard_payload
    { "payload"=> "{  \"url\":\"http://jumpstartlab.com/blog\",
                      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                      \"respondedIn\":37,
                      \"referredBy\":\"http://jumpstartlab.com\",
                      \"requestType\":\"GET\",
                      \"eventName\": \"socialLogin\",
                      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                      \"resolutionWidth\":\"1920\",
                      \"resolutionHeight\":\"1280\",
                      \"ip\":\"63.29.38.211\" }",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "identifier"=>"jumpstartlab"}
  end

  def create_source_and_payload
    source = Source.create({ identifier: "jumpstartlab",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                             "requestedAt"=>"2013-02-16 21:38:28 -0700",
                             "respondedIn"=>37,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })
  end

  def create_different_source_and_payload
    source = Source.create({ identifier: "google",
                             rootUrl:    "http://google.com" })

    source.payloads.create({ "url"=>"http://google.com/video",
                             "requestedAt"=>"2013-02-16 21:38:28 -0700",
                             "respondedIn"=>39,
                             "referredBy"=>"http://referredby.com",
                             "requestType"=>"POST",
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1280",
                             "resolutionHeight"=>"720",
                             "ip"=>"77.29.77.277" })
  end

  def create_additional_payloads
    source = Source.create({ identifier: "jumpstartlab",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                             "requestedAt"=>"2014-02-16 10:38:28 -0700",
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

     source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                              "requestedAt"=>"2014-02-16 19:38:28 -0700",
                              "respondedIn"=>37,
                              "referredBy"=>"http://jumpstartlab.com",
                              "requestType"=>"GET",
                              "parameters"=>[],
                              "eventName"=>"bannerClick",
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
                             "requestedAt"=>"2013-02-16 10:38:28 -0700",
                             "respondedIn"=>37,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })
  end

  def create_third_source_and_payload
    source = Source.create({ identifier: "jumpstartlabs",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/team",
                             "requestedAt"=>"2013-02-16 21:38:28 -0700",
                             "respondedIn"=>20,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
                             "eventName"=>"socialLogin",
                             "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })
  end

  def create_source_and_payload_no_symbols
    source = Source.create({ "identifier" => "jumpstartlab",
                             "rootUrl"    =>    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                             "requestedAt"=>"2013-02-16 19:38:28 -0700",
                             "respondedIn"=>37,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
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
