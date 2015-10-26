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
    assert_equal({"socialLogin"=> 2, "bannerClick"=> 1}, Source.sort_events_received("jumpstartlab"))
  end

  def test_find_event_data_over_24hrs
    create_event_test_payloads
    assert_equal([{"socialLogin"=>"10pm - 11pm"}, {"socialLogin"=>"10am - 11am"}, {"bannerClick"=>"8pm - 9pm"}], Source.find_event_data_over_24hrs("jumpstartlab"))
  end

  def test_it_finds_how_many_total_times_event_recieved
    create_event_test_payloads
    event = "socialLogin"
    assert_equal(2, Source.find_times_event_received(event, "jumpstartlab"))
  end

  def test_create_breakdown_hash
    create_event_test_payloads
    assert_equal({{"socialLogin"=>"10pm - 11pm"}=>[{"socialLogin"=>"10pm - 11pm"}],
 {"socialLogin"=>"10am - 11am"}=>[{"socialLogin"=>"10am - 11am"}],
 {"bannerClick"=>"8pm - 9pm"}=>[{"bannerClick"=>"8pm - 9pm"}]}, Source.create_breakdown_hash("jumpstartlab"))
  end

end
