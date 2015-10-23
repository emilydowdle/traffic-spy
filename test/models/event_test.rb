require_relative '../test_helper'
require_relative "../../app/controllers/server"

class EventTest < Minitest::Test

  def test_events_sorted_by_visit
    create_source_and_payload

    binding.pry
    assert_equal [["socialLogin", 1]], Event.sort_events_received("jumpstartlab")

  end

end
