require_relative '../test_helper'

class UrlStatsTest < Minitest::Test

# def create_source_and_payload_for_nil_url
#   source = Source.create({ identifier: "jumpstartlab",
#                            rootUrl:    "http://jumpstartlab.com" })
#
#   source.payloads.create({ "url"=>"",
#                            "requestedAt"=>"2013-02-16 21:38:28 -0700",
#                            "respondedIn"=>37,
#                            "referredBy"=>"http://jumpstartlab.com",
#                            "requestType"=>"GET",
#                            "parameters"=>[],
#                            "eventName"=>"socialLogin",
#                            "userAgent"=> "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                            "resolutionWidth"=>"1920",
#                            "resolutionHeight"=>"1280",
#                            "ip"=>"63.29.38.211" })
#
# end
#
  def create_source_and_payload
    source = Source.create({ identifier: "jumpstartlab",
                             rootUrl:    "http://jumpstartlab.com" })

    source.payloads.create({ "url"=>"http://jumpstartlab.com/blog",
                             "requestedAt"=>"2013-02-16 21:38:28 -0700",
                             "respondedIn"=>37,
                             "referredBy"=>"http://jumpstartlab.com",
                             "requestType"=>"GET",
                             "eventName"=>"socialLogin",
                             "userAgent"=>
                             "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             "resolutionWidth"=>"1920",
                             "resolutionHeight"=>"1280",
                             "ip"=>"63.29.38.211" })

  end

  def test_that_payload_has_url
    payload_source = create_source_and_payload
    assert_equal true, payload_source[:url].present?
  end

  def test_that_url_does_not_exist_receives_error
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/asdf'
    assert page.has_content? ("URL has not been requested")
  end

  def test_user_can_see_response_time
    create_source_and_payload
    visit '/source/jumpstartlab/urls/blog'
    save_and_open_page
    assert page.has_content? ("GET")
  end

  #
  def test_client_can_navigate_to_url_specific_page
    skip
    visit '/sources/jumpstartlab/urls/blog'
    within("h1") do
      assert page.has_content?("http://jumpstartlab.com/blog/statistics")
    end
  end

  def test_can_return_longest_response_time
    skip
    visit '/sources/jumpstartlab/urls/blog'
    within("#url_response_times") do
      assert page.has_content?(87)
      assert page.has_content?(/longest|Longest/)
    end
  end

  def test_can_return_shortest_response_time
    skip
    visit '/sources/jumpstartlab/urls/blog'
    within("#url_response_times") do

      assert page.has_content?(37)
    end
  end

  def test_shows_average_response_time
    skip
    visit '/sources/jumpstartlab/urls/blog'
    within("#url_response_times") do
      
      assert page.has_content?(37)
    end
  end

  def test_shows_error_for_url_with_additional_path
    skip
    visit '/sources/jumpstartlab/urls/blog/1'
    assert page.has_content?("There is an error on this page")
  end

  def test_shows_data_for_url_with_additional_path
    skip
    visit '/sources/jumpstartlab/urls/blog/2'

    within("h1") do
      assert page.has_content?("http://jumpstartlab.com/blog/2 Statistics")
    end

    within("#url_response_times") do
      assert page.has_content?(99)
    end
  end

  # def test_shows_which_http_verbs_have_been_used
  #   skip
  #   visit '/sources/jumpstartlab/urls/blog'
  #   within("#http_verbs") do
  #     assert page.has_content?("POST")
  #   end
  # end
  #
  # def test_most_popular_referred_by
  #   skip
  #   visit '/sources/jumpstartlab/urls/blog'
  #   within("#most_reffered_by") do
  #     assert page.has_content?("http://jumpstartlab.com")
  #   end
  # end

  def test_most_popular_user_agents

    visit '/sources/jumpstartlab/urls/blog'
    within("#most_popular_user_agents") do
      assert page.has_content?("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    end
  end
end
















  def test_user_can_see_page
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'

    assert_equal '/sources/jumpstartlab/urls/blog', current_path
    assert page.has_content? ("List of Agents")
  end

  # def test_agents_exist
  #   visit '/sources/jumpstartlab/urls/blog'
  #
  #   assert_equal '/sources/jumpstartlab/urls/blog', current_path
  #   assert_equal 1, create_source_and_payload[:id]
  #   assert_equal 2, create_source_and_payload[:id]
  #   assert_equal 3, create_source_and_payload[:id]
  # end
end
#   def test_user_gets_message_url_not_requested
#     visit '/sources/jumpstartlab/urls/blog'
#
#     assert_equal '/sources/jumpstartlab/urls/blog', current_path
#     assert "URL has not been requested", create_source_and_payload_for_nil_url[:url].nil? || create_source_and_payload_for_nil_url[:url].empty?
#   end
# end
