require './test/test_helper'

class TrafficSpyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_can_submit_post_and_get_200_ok
    post '/sources', { identifier: "something",
                       rootUrl:    "else" }

    assert_equal 200, last_response.status
  end

  def test_returns_400_if_missing_title
    post '/sources', { rootUrl:    "else" }
    assert_equal 400, last_response.status
  end

end
