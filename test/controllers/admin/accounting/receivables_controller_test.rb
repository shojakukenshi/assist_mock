require "test_helper"

class Admin::Accounting::ReceivablesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_receivables_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_accounting_receivables_path
    assert_response :success
    assert_select '[data-receivable-detail-target="panel"]', 1, "Detail panel should exist for receivable details"
  end

  test "detail panel should have proper structure" do
    get admin_accounting_receivables_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="receivable-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have close button
    assert_select '[data-receivable-detail-target="panel"] button[data-action*="receivable-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-receivable-detail-target="clientName"]', 1
    assert_select '[data-receivable-detail-target="projectName"]', 1
    assert_select '[data-receivable-detail-target="amount"]', 1
    assert_select '[data-receivable-detail-target="statusBadge"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_accounting_receivables_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="receivable-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for receivable data
    assert_select 'tbody tr[data-receivable]',
                  minimum: 1,
                  message: "Table rows should have receivable data attribute"
  end
end
