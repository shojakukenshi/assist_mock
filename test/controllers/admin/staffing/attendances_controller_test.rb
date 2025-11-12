require "test_helper"

class Admin::Staffing::AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_attendances_path
    assert_response :success
  end
end
