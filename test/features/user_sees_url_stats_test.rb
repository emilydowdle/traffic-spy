require_relative '../test_helper'

class UrlStatsTest < Minitest::Test

  def test_user_can_see_page
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'

    assert_equal '/sources/jumpstartlab/urls/blog', current_path
    assert page.has_content? ("List of Agents")
  end

  def test_agents_exist
    visit '/sources/jumpstartlab/urls/blog'

    assert_equal '/sources/jumpstartlab/urls/blog', current_path
    assert_equal 1, create_source_and_payload[:id]
    assert_equal 2, create_source_and_payload[:id]
    assert_equal 3, create_source_and_payload[:id]
  end

  def test_user_can_see_agents
    
    visit '/sources/jumpstartlab/urls/blog'

    assert_equal '/sources/jumpstartlab/urls/blog', current_path

  end
end
    # binding.pry
