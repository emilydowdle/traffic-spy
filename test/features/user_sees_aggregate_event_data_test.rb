require_relative "../test_helper"

class EventTest < FeatureTest

  def test_user_is_able_to_view_aggregate_event_data
    create_source_and_payload

    visit '/sources/jumpstartlab/events'

    assert_equal "/sources/jumpstartlab/events", current_path
    assert page.has_content?("Most received event to least received event")
  end

end
