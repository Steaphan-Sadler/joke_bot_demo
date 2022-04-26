require "test_helper"

class JokeControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch" do
    get joke_fetch_url
    assert_response :success
  end
end
