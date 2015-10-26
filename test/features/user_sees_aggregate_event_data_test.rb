require_relative "../test_helper"

class EventTest < FeatureTest

  def create_event_test_payloads
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

  def test_users_view_is_current_path
    create_source_and_payload

    visit '/sources/jumpstartlab/events'
    assert_equal "/sources/jumpstartlab/events", current_path
  end

  def test_user_can_see_page
    create_source_and_payload

    visit '/sources/jumpstartlab/events'
    assert page.has_text? ("Events")
  end

  def test_user_sees_most_received_event_to_least_received_event
    create_event_test_payloads
    visit '/sources/jumpstartlab/events'
    assert page.has_content? ("Most received event to least received event")
  end

  def test_user_sees_event_frequency_data
    create_event_test_payloads
    visit '/sources/jumpstartlab/events'

    assert page.has_text?(2)
  end

  def test_user_sees_event_names_as_hyperlink
    create_event_test_payloads
    visit '/sources/jumpstartlab/events'
    assert page.has_content? ("socialLogin")
    find_link('socialLogin').visible?
  end

  def test_user_can_view_event_application_events_details_page
    create_event_test_payloads
    visit '/sources/jumpstartlab/events/socialLogin'
    assert page.has_content? ("Hour by hour breakdown of when the event was received")

  end




end
