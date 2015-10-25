require_relative "../test_helper"

class EventTest < FeatureTest

  def test_users_view_is_current_path
    create_source_and_payload
    visit '/sources/jumpstartlab/events'

    # event_data = sort_events_received
    assert_equal "/sources/jumpstartlab/events", current_path
    # assert page.has_content?("Most received event to least received event")
  end

  def test_user_can_see_page
    create_source_and_payload
    visit '/sources/jumpstartlab/events'
    assert page.has_text? ("Events")
  end

end
