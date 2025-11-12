require "test_helper"

class Admin::Accounting::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_expenses_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_accounting_expenses_path
    assert_response :success
    assert_select '[data-accounting-expense-detail-target="panel"]', 1, "Detail panel should exist for accounting expense details"
  end
end
