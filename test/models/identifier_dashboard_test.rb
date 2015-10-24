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
    create_additional_payloads

    assert_equal [["Chrome", 2]], Dashboard.browser_data("jumpstartlab")
  end

  def test_os_data_across_all_requests
    create_additional_payloads

    assert_equal [["Macintosh", 2]], Dashboard.os_data("jumpstartlab")
  end

  def test_find_screen_resolution_all_requests
    create_additional_payloads

    assert_equal [[["1920", "1280"], 2]], Dashboard.find_screen_resolution_across_requests("jumpstartlab")
  end

  def test_find_screen_resolution_all_requests
    create_additional_payloads

    assert_equal [[37, 2]], Dashboard.response_time_across_all_requests("jumpstartlab")
  end

  def test_returns_all_information_in_hash
    create_additional_payloads

    assert_equal ({:url=>[["http://jumpstartlab.com/blog", 2]], :browser=>[["Chrome", 2]], :operating_system=>[["Macintosh", 2]], :screen_resolution=>[[["1920", "1280"], 2]], :response_time=>[[37, 2]]}), Dashboard.find_all_data_for_dashboard("jumpstartlab")
  end

end
