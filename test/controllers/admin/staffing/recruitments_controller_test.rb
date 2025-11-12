require "test_helper"

class Admin::Staffing::RecruitmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_recruitments_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_recruitments_path
    assert_response :success
    assert_select '[data-recruitment-detail-target="panel"]', 1, "Detail panel should exist for recruitment details"
  end
end
