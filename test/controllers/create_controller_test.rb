require './test/test_helper'
require 'tilt/erb'

module TrafficSpy
  class TrafficSpyAppTest < Minitest::Test
    include Rack::Test::Methods

    PARAMS = {"payload"=> "{\"url\":\"http://jumpstartlab.com/blog\",
                            \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
                            \"respondedIn\":37,
                            \"referredBy\":\"http://jumpstartlab.com\",
                            \"requestType\":\"GET\",
                            \"parameters\":[],
                            \"eventName\": \"socialLogin\",
                            \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
                            \"resolutionWidth\":\"1920\",
                            \"resolutionHeight\":\"1280\",
                            \"ip\":\"63.29.38.211\"}",
                            "splat"=>[],
                            "captures"=>["jumpstartlab"],
                            "identifier"=>"jumpstartlab"}

    def app
      TrafficSpy::Server
    end

    def setup
      DatabaseCleaner.start
    end

    def teardown
      DatabaseCleaner.clean
    end

    def test_can_submit_post_and_get_200_ok
      post '/sources', { identifier: "something",
                         rootUrl:    "else" }

      assert_equal 200, last_response.status
    end

    def test_returns_400_if_missing_title
      post '/sources', { rootUrl:    "else" }
      assert_equal 400, last_response.status
    end

    def test_can_submit_post_and_get_200_ok
      post '/sources', { identifier: "something",
                         rootUrl:    "else" }

      assert_equal 200, last_response.status
    end

    def test_returns_400_if_missing_identifier
      post '/sources', { rootUrl:    "else" }

      assert_equal 400, last_response.status
      assert_equal "Identifier can't be blank", last_response.body
    end

    def test_returns_400_if_missing_rootUrl
      post '/sources', { identifier:  "something" }

      assert_equal 400, last_response.status
      assert_equal "Rooturl can't be blank", last_response.body
    end

    def test_returns_403_if_identifier_already_exists
      post '/sources', { identifier: "something",
                         rootUrl:    "else" }

      assert_equal 200, last_response.status

      post '/sources', { identifier: "something",
                         rootUrl:    "something else" }

      assert_equal 403, last_response.status
      assert_equal "Identifier already exists{ something => something else }", last_response.body
    end

    def test_unregistered_user_cannot_access_user_dashboard
      skip
      post '/sources', { identifier: "something",
                         rootUrl:    "something else" }

      get '/sources/wrong-identifier'

      assert_equal "That identifier does not exist", last_response.body
    end

    def test_registered_user_can_reach_the_dashboard
      skip
      post '/sources', { identifier: "something",
                         rootUrl:    "something else" }

      get '/sources/something'

      assert_equal "", last_response.body
    end

    def test_curl_request_can_be_processed
      post '/sources', { identifier: "jumpstartlab",
                         rootUrl:    "http://jumpstartlab.com" }

      post '/sources/jumpstartlab/data', PARAMS

      assert_equal "http://jumpstartlab.com/blog", data["url"]
    end

  end
end
