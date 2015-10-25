require_relative '../test_helper'

class UrlStatsTest < Minitest::Test

  def run_this_method
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    post '/sources', 'identifier=google&rootUrl=http://google.com'
    post '/sources/jumpstartlab/urls/blog', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    post '/sources/jumpstartlab/urls/blog', 'payload={"url":"http://jumpstartlab.com/blog/2","requestedAt":"2013-02-17 21:38:28 -0700","respondedIn":41,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    post '/sources/jumpstartlab/urls/blog', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":35,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    post '/sources/jumpstartlab/urls/blog', 'payload={"url":"http://jumpstartlab.com/blog/5","requestedAt":"2013-02-14 21:38:28 -0700","respondedIn":33,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    post '/sources/jumpstartlab/urls/blog', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

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
    assert_equal '/sources/jumpstartlab/urls/asdf', current_path
  end

  def test_shows_which_http_verbs_have_been_used
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#http_verbs") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_content?("GET")
    end
  end

  def test_user_sees_most_popular_referred_by
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#most_referred_by") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      # assert page.has_content?("http://jumpstartlab.com")
      assert page.has_content?("Most Referred By")
    end
  end

  def test_user_sees_most_popular_user_agents
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#most_popular_agents") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_text? ("Macintosh")
      assert page.has_content? ("Most Popular User Agents")
    end
  end

  def test_user_sees_average_response_time
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    save_and_open_page
    within("#average_response_time") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_text? (37)
      assert page.has_content? ("Average Response Time")
    end
  end

  def test_user_sees_longest_response_time
    create_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#longest_response_time") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_text? (37)
      assert page.has_text? ("Longest Response Time")
    end
  end

  def test_user_sees_shortest_response_time
    create_source_and_payload
    create_different_source_and_payload
    visit '/sources/jumpstartlab/urls/blog'
    within("#shortest_response_time") do
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_text? (37)
      assert page.has_content? ("Shortest Response Time")
    end
  end

  def test_user_sees_average_of_multiple_response_times
    create_source_and_payload
    create_source_and_payload
    create_different_source_and_payload
    create_different_source_and_payload
  binding.pry
    visit '/sources/jumpstartlab/urls/blog'
    within("#average_response_time") do
      assert page.has_content? (39)
      assert page.has_content? (37)
    end
  end
end
