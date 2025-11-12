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
end
