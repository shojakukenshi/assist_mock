require "test_helper"

class Admin::Settings::Mypage::AnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_mypage_analytics_path
    assert_response :success
  end

  test "should display analytics data" do
    get admin_settings_mypage_analytics_path
    assert_response :success
    assert_select 'h1', text: /アクセス解析/, minimum: 0
  end
end
