require "test_helper"

class Admin::Staffing::RecruitmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_recruitments_path
    assert_response :success
  end
end
