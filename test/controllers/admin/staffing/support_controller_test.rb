require "test_helper"

class Admin::Staffing::SupportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_support_index_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_support_index_path
    assert_response :success
    assert_select '[data-support-detail-target="panel"]', 1, "Detail panel should exist for support details"
  end

  test "detail panel should have proper structure" do
    get admin_staffing_support_index_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="support-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have close button
    assert_select '[data-support-detail-target="panel"] button[data-action*="support-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-support-detail-target="title"]', 1
    assert_select '[data-support-detail-target="staffName"]', 1
    assert_select '[data-support-detail-target="priority"]', 1
    assert_select '[data-support-detail-target="status"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_staffing_support_index_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="support-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for support data
    assert_select 'tbody tr[data-support]',
                  minimum: 1,
                  message: "Table rows should have support data attribute"
  end
end
