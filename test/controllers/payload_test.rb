require_relative '../test_helper'
require_relative '../../app/models/payload_parser.rb'

class PayloadTest < Minitest::Test
  include Rack::Test::Methods

  PARAMS = {"payload"=>
           "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
        }

  def app
    TrafficSpy::Server
  end

  def test_receives_success_200_ok
    skip
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', PARAMS
    assert_equal 200, last_response.status
    assert_equal "payload registered", last_response.body
  end

  def test_receives_400_bad_request_for_missing_payload
    skip
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', {"payload" => "{}"}
    assert_equal 400, last_response.status
    assert_equal "Bad Request: Missing Payload", last_response.body
  end

  def test_receives_403_unregistered_user
    skip
    post '/sources/jumpstartlab/data', PARAMS
    assert_equal 403, last_response.status
    assert_equal "unregistered user", last_response.body
  end

  def test_receives_403_duplicate_payload
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', PARAMS
    assert_equal 200, last_response.status
    post '/sources/jumpstartlab/data', PARAMS
    assert_equal 403, last_response.status
    assert_equal "duplicate payload", last_response.body
  end
end
