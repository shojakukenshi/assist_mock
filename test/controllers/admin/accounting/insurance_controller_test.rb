require "test_helper"

class Admin::Accounting::InsuranceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_accounting_insurance_index_path
    assert_response :success
  end

  test "index page should display summary cards" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # サマリーカードが表示されていること
    assert_select '.text-3xl.font-bold', minimum: 5
  end

  test "index page should display staff insurance list" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # スタッフリストのテーブルが表示されていること
    assert_select 'table tbody tr', minimum: 1
  end

  test "index page should display premium trends" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # 保険料推移セクションが表示されていること
    assert_select 'h2', text: '月次保険料推移'
  end

  test "index page should display health checkup status" do
    get admin_accounting_insurance_index_path
    assert_response :success

    # 健康診断実施状況が表示されていること
    assert_select 'h2', text: '健康診断実施状況'
  end
end
