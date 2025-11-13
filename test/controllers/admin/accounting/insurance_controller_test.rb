require "test_helper"

class Admin::Accounting::InsuranceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_insurance_index_path
    assert_response :success
  end

  # 社会保険料計算フローのテスト
  test "should get social_insurance_step1" do
    get social_insurance_step1_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute social_insurance_step1" do
    post execute_social_insurance_step1_admin_accounting_insurance_path(id: 1)
    assert_redirected_to social_insurance_step2_admin_accounting_insurance_path(1)
  end

  test "should get social_insurance_step2" do
    get social_insurance_step2_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute social_insurance_step2" do
    post execute_social_insurance_step2_admin_accounting_insurance_path(id: 1)
    assert_redirected_to social_insurance_step3_admin_accounting_insurance_path(1)
  end

  test "should get social_insurance_step3" do
    get social_insurance_step3_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute social_insurance_step3" do
    post execute_social_insurance_step3_admin_accounting_insurance_path(id: 1)
    assert_redirected_to social_insurance_step4_admin_accounting_insurance_path(1)
  end

  test "should get social_insurance_step4" do
    get social_insurance_step4_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute social_insurance_step4" do
    post execute_social_insurance_step4_admin_accounting_insurance_path(id: 1)
    assert_redirected_to social_insurance_step5_admin_accounting_insurance_path(1)
  end

  test "should get social_insurance_step5" do
    get social_insurance_step5_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute social_insurance_step5" do
    post execute_social_insurance_step5_admin_accounting_insurance_path(id: 1)
    assert_redirected_to social_insurance_step6_admin_accounting_insurance_path(1)
  end

  test "should get social_insurance_step6" do
    get social_insurance_step6_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  # 源泉徴収処理フローのテスト
  test "should get withholding_tax_step1" do
    get withholding_tax_step1_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute withholding_tax_step1" do
    post execute_withholding_tax_step1_admin_accounting_insurance_path(id: 1)
    assert_redirected_to withholding_tax_step2_admin_accounting_insurance_path(1)
  end

  test "should get withholding_tax_step2" do
    get withholding_tax_step2_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute withholding_tax_step2" do
    post execute_withholding_tax_step2_admin_accounting_insurance_path(id: 1)
    assert_redirected_to withholding_tax_step3_admin_accounting_insurance_path(1)
  end

  test "should get withholding_tax_step3" do
    get withholding_tax_step3_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute withholding_tax_step3" do
    post execute_withholding_tax_step3_admin_accounting_insurance_path(id: 1)
    assert_redirected_to withholding_tax_step4_admin_accounting_insurance_path(1)
  end

  test "should get withholding_tax_step4" do
    get withholding_tax_step4_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute withholding_tax_step4" do
    post execute_withholding_tax_step4_admin_accounting_insurance_path(id: 1)
    assert_redirected_to withholding_tax_step5_admin_accounting_insurance_path(1)
  end

  test "should get withholding_tax_step5" do
    get withholding_tax_step5_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end

  test "should execute withholding_tax_step5" do
    post execute_withholding_tax_step5_admin_accounting_insurance_path(id: 1)
    assert_redirected_to withholding_tax_step6_admin_accounting_insurance_path(1)
  end

  test "should get withholding_tax_step6" do
    get withholding_tax_step6_admin_accounting_insurance_path(id: 1)
    assert_response :success
  end
end
