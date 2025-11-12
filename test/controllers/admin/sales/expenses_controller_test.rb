require "test_helper"

class Admin::Sales::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sales_expenses_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_sales_expenses_path
    assert_response :success
    assert_select '[data-expense-detail-target="panel"]', 1, "Detail panel should exist for expense details"
  end

  test "detail panel should have proper structure" do
    get admin_sales_expenses_path
    assert_response :success

    # Stimulus controller should be connected
    assert_select '[data-controller~="expense-detail"]', 1, "Stimulus controller should be connected"

    # Panel should have overlay
    assert_select '[data-expense-detail-target="overlay"]', 1, "Overlay should exist"

    # Panel should have close button
    assert_select '[data-expense-detail-target="panel"] button[data-action*="expense-detail#close"]',
                  minimum: 1,
                  message: "Close button should exist in panel"

    # Panel should have data targets for content
    assert_select '[data-expense-detail-target="date"]', 1
    assert_select '[data-expense-detail-target="category"]', 1
    assert_select '[data-expense-detail-target="amount"]', 1
    assert_select '[data-expense-detail-target="statusBadge"]', 1
  end

  test "table rows should be clickable with data attributes" do
    get admin_sales_expenses_path
    assert_response :success

    # Rows should have click action
    assert_select 'tbody tr[data-action*="expense-detail#open"]',
                  minimum: 1,
                  message: "Table rows should have click action for opening detail"

    # Rows should have data attribute for expense data
    assert_select 'tbody tr[data-expense]',
                  minimum: 1,
                  message: "Table rows should have expense data attribute"
  end
end
