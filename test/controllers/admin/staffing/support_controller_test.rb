require "test_helper"

class Admin::Staffing::SupportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_support_index_path
    assert_response :success
  end
end
