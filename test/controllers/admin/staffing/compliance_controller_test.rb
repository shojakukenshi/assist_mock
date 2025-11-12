require "test_helper"

class Admin::Staffing::ComplianceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_compliance_index_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_compliance_index_path
    assert_response :success
    assert_select '[data-compliance-detail-target="panel"]', 1, "Detail panel should exist for compliance details"
  end

  test "detail panel should have proper structure" do
    get admin_staffing_compliance_index_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="compliance-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have overlay
    assert_select '[data-compliance-detail-target="overlay"]', 1, "Overlay should exist"

    # Panel should have close button
    assert_select '[data-compliance-detail-target="panel"] button[data-action*="compliance-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-compliance-detail-target="auditType"]', 1
    assert_select '[data-compliance-detail-target="auditor"]', 1
    assert_select '[data-compliance-detail-target="result"]', 1
    assert_select '[data-compliance-detail-target="auditDate"]', 1
  end

  test "audit table rows should be clickable with data attributes" do
    get admin_staffing_compliance_index_path
    assert_response :success

    # Audit rows should have click action
    assert_select 'tbody tr[data-action*="compliance-detail#open"]',
                  minimum: 1,
                  message: "Audit table rows should have click action for opening detail"

    # Rows should have data attribute for compliance data
    assert_select 'tbody tr[data-compliance]',
                  minimum: 1,
                  message: "Audit rows should have compliance data attribute"
  end
end
