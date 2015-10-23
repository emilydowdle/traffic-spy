require './test/test_helper'
require_relative "../../app/controllers/server"

class DashboardTest < Minitest::Test

  def test_urls_sorted_by_visit
    create_source_and_payload
    create_second_source_and_payload
    create_third_source_and_payload

    assert_equal [["http://jumpstartlab.com/blog", 1]], Dashboard.sort_urls_by_visit("jumpstartlab")
    assert_equal [["http://google.com/analytics", 1]], Dashboard.sort_urls_by_visit("google")

  end

  def test_browser_data_across_all_requests
    create_source_and_payload
    create_second_source_and_payload
    create_third_source_and_payload

    assert_equal [["Chrome", 1]], Dashboard.display_browser_data("jumpstartlab")
    assert_equal [["Chrome", 1]], Dashboard.display_browser_data("google")
  end
end
