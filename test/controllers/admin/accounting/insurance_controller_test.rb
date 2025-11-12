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

  test "detail panel should have proper structure" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="insurance-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have data targets for content
    assert_select '[data-insurance-detail-target="panel"]', 1
    assert_select '[data-insurance-detail-target="employeeName"]', 1
    assert_select '[data-insurance-detail-target="healthInsurance"]', 1
    assert_select '[data-insurance-detail-target="pension"]', 1
    assert_select '[data-insurance-detail-target="totalAmount"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="insurance-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for insurance data
    assert_select 'tbody tr[data-insurance]',
                  minimum: 1,
                  message: "Table rows should have insurance data attribute"
  end
end
