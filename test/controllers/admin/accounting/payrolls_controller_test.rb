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

  test "detail panel should have proper structure" do
    get admin_accounting_payrolls_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="payroll-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have overlay
    assert_select '[data-payroll-detail-target="overlay"]', 1, "Overlay should exist"

    # Panel should have close button
    assert_select '[data-payroll-detail-target="panel"] button[data-action*="payroll-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-payroll-detail-target="employeeName"]', 1
    assert_select '[data-payroll-detail-target="employeeCode"]', 1
    assert_select '[data-payroll-detail-target="baseSalary"]', 1
    assert_select '[data-payroll-detail-target="status"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_accounting_payrolls_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="payroll-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for payroll data
    assert_select 'tbody tr[data-payroll]',
                  minimum: 1,
                  message: "Table rows should have payroll data attribute"
  end
end
