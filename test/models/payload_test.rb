require_relative '../test_helper'
require_relative '../../app/models/payload_parser.rb'

class PayloadTest < Minitest::Test

  def test_that_payload_accepts_string
    payload = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    Payload.clean_data(payload)

    assert_equal "http://jumpstartlab.com/blog", payload[:url]
  end

end
