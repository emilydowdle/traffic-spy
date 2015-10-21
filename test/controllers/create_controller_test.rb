require './test/test_helper'
require 'tilt/erb'
  module TrafficSpy
  class TrafficSpyAppTest < Minitest::Test
    include Rack::Test::Methods

    def app
      TrafficSpy::Server
    end

    def setup
      
    end

    def test_can_submit_post_and_get_200_ok
      post '/sources', { identifier: "something",
                         rootUrl:    "else" }

      assert_equal 200, last_response.status
    end
    # Missing Parameters - 400 Bad Request
    # If missing any of the required parameters return status 400 Bad Request with a descriptive error message.
    def test_returns_400_if_missing_title
      post '/sources', { rootUrl:    "else" }
      assert_equal 400, last_response.status
    end

    def test_returns_403_ok_when_payload_sent
      post '/sources/:identifier/data', { identifier: "something",
                                          payload: {
                                          "url":"http://jumpstartlab.com/blog",
                                          "requestedAt":"2013-02-16 21:38:28 -0700",
                                          "respondedIn":37,
                                          "referredBy":"http://jumpstartlab.com",
                                          "requestType":"GET",
                                          "parameters":[],
                                          "eventName": "socialLogin",
                                          "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                          "resolutionWidth":"1920",
                                          "resolutionHeight":"1280",
                                          "ip":"63.29.38.211"}}


      assert_equal 200, last_response.status
    end

  end
end
