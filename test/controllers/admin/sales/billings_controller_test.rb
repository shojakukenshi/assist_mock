require "test_helper"

class Admin::Sales::BillingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sales_billings_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_sales_billings_path
    assert_response :success
    assert_select '[data-billing-detail-target="panel"]', 1, "Detail panel should exist for billing details"
  end

  test "detail panel should have proper structure" do
    get admin_sales_billings_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="billing-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have close button
    assert_select '[data-billing-detail-target="panel"] button[data-action*="billing-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-billing-detail-target="invoiceNumber"]', 1
    assert_select '[data-billing-detail-target="clientName"]', 1
    assert_select '[data-billing-detail-target="amount"]', 1
    assert_select '[data-billing-detail-target="statusBadge"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_sales_billings_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="billing-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for billing data
    assert_select 'tbody tr[data-billing]',
                  minimum: 1,
                  message: "Table rows should have billing data attribute"
  end
end
