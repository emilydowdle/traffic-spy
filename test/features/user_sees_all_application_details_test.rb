require_relative "../test_helper"
require_relative "../../controllers/server"

class AppDetailTest < FeatureTest

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

  def test_user_can_see_url_detail
    create_source_and_payload

    visit '/sources/jumpstartlab'

    assert_equal "/sources/jumpstartlab", current_path
    assert page.has_content?("http://jumpstartlab.com/blog")
  end

end
