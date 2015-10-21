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

  def test_returns_400_if_missing_identifier
    post '/sources', { rootUrl:    "else" }

    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_returns_400_if_missing_rootUrl
    post '/sources', { identifier:  "something" }

    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end

  def test_returns_403_if_identifier_already_exists
    post '/sources', { identifier: "something",
                       rootUrl:    "else" }

    assert_equal 200, last_response.status

    post '/sources', { identifier: "something",
                       rootUrl:    "something else" }

    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
  end

  def test_unregistered_user_cannot_access_user_dashboard
    post '/sources', { identifier: "something",
                       rootUrl:    "something else" }

    get '/sources/wrong-identifier'

    assert_equal "That identifier does not exist", last_response.body
  end

  def test_registered_user_can_reach_the_dashboard
    skip
    post '/sources', { identifier: "something",
                       rootUrl:    "something else" }

    get '/sources/something'

    assert_equal
    assert_equal "", last_response.body
  end


end
