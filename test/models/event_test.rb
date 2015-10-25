require_relative '../test_helper'
require_relative "../../app/controllers/server"

class EventTest < Minitest::Test

  def test_events_sorted_by_visit
    create_source_and_payload
    create_additional_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    assert_equal({"socialLogin"=> 2, "bannerClick"=> 1}, source.sort_events_received)

  end

  def test_find_event_data_over_24hrs
    skip
    create_source_and_payload
    create_additional_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    assert_equal({"socialLogin"=> 21, "socialLogin"=> 10, "bannerClick"=> 19}, source.find_event_data_over_24hrs)
  end

  def test_it_finds_how_many_total_times_event_recieved
    skip
    create_source_and_payload
    create_additional_payloads
    event = "socialLogin"
    assert_equal(2, source.find_times_event_received(event))
  end

end
