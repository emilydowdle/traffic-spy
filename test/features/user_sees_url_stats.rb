require_relative "../test_helper"

class UrlStatsTest < FeatureTest

  def test_page_has_title
    source_create
    visit '/sources/jumpstartlab/urls/blog'

    assert_equal '/sources/jumpstartlab/urls/blog', current_path
    assert has_content? ("Jumpstart Lab Statistics")
    binding.pry
  end
end
