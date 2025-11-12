require "test_helper"

class Admin::Staffing::AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_assignments_path
    assert_response :success
  end
end
