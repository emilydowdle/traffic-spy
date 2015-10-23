require_relative '../test_helper'
require_relative "../../app/controllers/server"

class EventTest < Minitest::Test

  def test_events_sorted_by_visit
    create_source_and_payload
    create_additional_payloads
    source = Source.find_by(identifier: "jumpstartlab")
    assert_equal({"socialLogin"=> 2, "bannerClick"=> 1}, source.sort_events_received)

  end

end
