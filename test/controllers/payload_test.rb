require_relative '../test_helper'
require_relative '../../app/models/payload_parser.rb'

class PayloadTest < Minitest::Test

  def test_receives_success_200_ok
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', standard_payload
    assert_equal 200, last_response.status
    assert_equal "payload registered", last_response.body
  end

  def test_receives_400_bad_request_for_missing_payload
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', {"payload" => ""}
    assert_equal 400, last_response.status
    assert_equal "Bad Request: Missing Payload", last_response.body
  end

  def test_receives_403_unregistered_user
    post '/sources/jumpstartlab/data', standard_payload
    assert_equal 403, last_response.status
    assert_equal "unregistered user", last_response.body
  end

  def test_receives_403_duplicate_payload
    Source.create(identifier: "jumpstartlab" , rootUrl: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', standard_payload
    assert_equal 200, last_response.status
    post '/sources/jumpstartlab/data', standard_payload
    assert_equal 403, last_response.status
    assert_equal "duplicate payload", last_response.body
  end
end
