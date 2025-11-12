require "test_helper"

class Admin::Accounting::PayrollsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_payrolls_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_accounting_payrolls_path
    assert_response :success
    assert_select '[data-payroll-detail-target="panel"]', 1, "Detail panel should exist for payroll details"
  end
end
