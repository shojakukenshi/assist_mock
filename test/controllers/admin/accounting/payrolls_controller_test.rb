require "test_helper"

class Admin::Accounting::PayrollsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_payrolls_path
    assert_response :success
  end

  test "should get new" do
    get new_admin_accounting_payroll_path
    assert_response :success
  end

  test "should get show" do
    get admin_accounting_payroll_path(id: 1)
    assert_response :success
  end

  test "should get wizard_step1" do
    get wizard_step1_admin_accounting_payroll_path(id: 1)
    assert_response :success
  end

  test "should get wizard_step2" do
    get wizard_step2_admin_accounting_payroll_path(id: 1)
    assert_response :success
  end

  test "should get wizard_step3" do
    get wizard_step3_admin_accounting_payroll_path(id: 1)
    assert_response :success
  end

  test "should get wizard_step4" do
    get wizard_step4_admin_accounting_payroll_path(id: 1)
    assert_response :success
  end

  test "should execute step1" do
    post execute_step1_admin_accounting_payroll_path(id: 1)
    assert_redirected_to wizard_step2_admin_accounting_payroll_path(1)
  end

  test "should execute step2" do
    post execute_step2_admin_accounting_payroll_path(id: 1)
    assert_redirected_to wizard_step3_admin_accounting_payroll_path(1)
  end

  test "should execute step3" do
    post execute_step3_admin_accounting_payroll_path(id: 1)
    assert_redirected_to wizard_step4_admin_accounting_payroll_path(1)
  end
end
