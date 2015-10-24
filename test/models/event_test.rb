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
    create_source_and_payload
    create_additional_payloads
    source = Source.find_by(identifier: "jumptartlab")
    assert_equal({"socialLogin"=> "1pm", "socialLogin"=> "2pm", "bannerClick"=> "10am", source.sort_find_event_data_over_24hrs})

  end

end
