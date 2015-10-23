require_relative "../test_helper"

class EventTest < FeatureTest
  def create_source_and_payload_for_nil_url
    source = Source.create({ identifier: "jumpstartlab",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"",
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

  def test_user_is_able_to_view_aggregate_event_data
    create_source_and_payload

    visit '/sources/jumpstartlab/events'

    event_data = sort_events_received

    assert_equal "/sources/jumpstartlab/events", current_path
    assert page.has_content?("Most received event to least received event")
  end

end
