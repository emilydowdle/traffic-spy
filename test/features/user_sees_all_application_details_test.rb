require_relative "../test_helper"
require_relative "../../app/controllers/server"

class AppDetailTest < FeatureTest

  def test_user_can_see_url_detail
    create_source_and_payload

    visit '/sources/jumpstartlab'

    assert_equal "/sources/jumpstartlab", current_path
    
  end

end
