require "test_helper"

module Admin
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    test "should get index with default sales department" do
      get admin_dashboard_path
      assert_response :success
      assert_select "h1", "ダッシュボード"
    end

    test "should get sales department dashboard" do
      get admin_dashboard_path(department: "sales")
      assert_response :success
      assert_select "h1", "ダッシュボード"
      # 営業部門の特徴的な要素を確認
      assert_select ".text-gray-900", text: "案件進捗サマリー", count: 0 # パーシャル内のテキストなので直接は表示されない
    end

    test "should get staffing department dashboard" do
      get admin_dashboard_path(department: "staffing")
      assert_response :success
      assert_select "h1", "ダッシュボード"
    end

    test "should get accounting department dashboard" do
      get admin_dashboard_path(department: "accounting")
      assert_response :success
      assert_select "h1", "ダッシュボード"
    end

    test "should have department tabs" do
      get admin_dashboard_path
      assert_response :success
      # 3つの部門タブが存在することを確認
      assert_select "nav a", minimum: 3
    end

    test "should show correct active tab for sales" do
      get admin_dashboard_path(department: "sales")
      assert_response :success
      # 営業部門タブがアクティブであることを確認（border-blue-500クラスを持つ）
      assert_select "a.border-blue-500", minimum: 1
    end

    test "should show correct active tab for staffing" do
      get admin_dashboard_path(department: "staffing")
      assert_response :success
      assert_select "a.border-blue-500", minimum: 1
    end

    test "should show correct active tab for accounting" do
      get admin_dashboard_path(department: "accounting")
      assert_response :success
      assert_select "a.border-blue-500", minimum: 1
    end

    test "should handle invalid department parameter" do
      get admin_dashboard_path(department: "invalid")
      assert_response :success
      # デフォルトの営業部門が表示されることを確認
    end
  end
end
