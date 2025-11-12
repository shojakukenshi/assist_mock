require "test_helper"

class Admin::Accounting::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_reports_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_accounting_reports_path
    assert_response :success
    assert_select '[data-report-detail-target="panel"]', 1, "Detail panel should exist for report details"
  end

  test "detail panel should have proper structure" do
    get admin_accounting_reports_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="report-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have overlay
    assert_select '[data-report-detail-target="overlay"]', 1, "Overlay should exist"

    # Panel should have close button
    assert_select '[data-report-detail-target="panel"] button[data-action*="report-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-report-detail-target="reportType"]', 1
    assert_select '[data-report-detail-target="targetPeriod"]', 1
    assert_select '[data-report-detail-target="statusBadge"]', 1
    assert_select '[data-report-detail-target="deadline"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_accounting_reports_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="report-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for report data
    assert_select 'tbody tr[data-report]',
                  minimum: 1,
                  message: "Table rows should have report data attribute"
  end
end
