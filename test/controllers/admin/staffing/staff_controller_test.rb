require "test_helper"

class Admin::Staffing::StaffControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_staff_index_path
    assert_response :success
  end
end
