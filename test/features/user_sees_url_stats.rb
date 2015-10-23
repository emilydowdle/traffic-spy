require_relative "../test_helper"

class UrlStatsTest < FeatureTest

  def test_page_has_identifier
      create_source_and_payload
      visit '/sources/jumpstartlab/events/socialLogin'

      assert_equal "/sources/jumpstartlab/events/socialLogin", current_path

  end
end
