require_relative '../test_helper'
require_relative "../../app/controllers/server"

class EventTest < Minitest::Test

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

  def test_events_sorted_by_visit
    create_event_test_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    assert_equal({"socialLogin"=> 2, "bannerClick"=> 1}, source.sort_events_received)

  end

  def test_find_event_data_over_24hrs
    create_event_test_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    assert_equal([{"socialLogin"=>"9pm - 10pm"}, {"socialLogin"=>"9am - 10am"}, {"bannerClick"=>"7pm - 8pm"}], source.find_event_data_over_24hrs)
  end

  def test_it_finds_how_many_total_times_event_recieved
    create_event_test_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    event = "socialLogin"
    assert_equal(2, source.find_times_event_received(event))
  end

end
