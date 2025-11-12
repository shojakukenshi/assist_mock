require "test_helper"

class Admin::Staffing::StaffControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_staff_index_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_staff_index_path
    assert_response :success
    assert_select '[data-staff-detail-target="panel"]', 1, "Detail panel should exist for staff details"
  end
end
