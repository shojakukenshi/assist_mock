require "test_helper"

class Admin::Accounting::InsuranceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_insurance_index_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_accounting_insurance_index_path
    assert_response :success
    assert_select '[data-insurance-detail-target="panel"]', 1, "Detail panel should exist for insurance details"
  end
end
