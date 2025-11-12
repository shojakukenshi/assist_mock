require "test_helper"

class Admin::Staffing::ComplianceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_compliance_index_path
    assert_response :success
  end
end
