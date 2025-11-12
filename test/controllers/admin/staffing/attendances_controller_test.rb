require "test_helper"

class Admin::Staffing::AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_attendances_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_attendances_path
    assert_response :success
    assert_select '[data-attendance-detail-target="panel"]', 1, "Detail panel should exist for attendance details"
  end
end
