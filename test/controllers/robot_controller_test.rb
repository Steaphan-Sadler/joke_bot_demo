require "test_helper"

class RobotControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get robot_index_url
    assert_response :success
  end
end
