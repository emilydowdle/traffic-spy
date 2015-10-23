require_relative "../test_helper"

class UrlStatsTest < FeatureTest

  def test_user_can_see_page_title
    create_source_and_payload

    visit '/sources/jumpstartlab/events/socialLogin'

    assert_equal '/sources/jumpstartlab/events/socialLogin', current_path
    assert page.has_content?("Jumpstart Lab Statistics")
  end

  def test_user_can_see_most_popular_user_agents
    skip
    create_source_and_payload

    visit '/sources/jumpstartlab/events/socialLogin'

    assert_equal "/sources/jumpstartlab/events/socialLogin", current_path
    assert page.has_content?("Most popular user ")
  end

end
