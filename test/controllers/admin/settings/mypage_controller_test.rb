require "test_helper"

class Admin::Settings::MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_mypage_path
    assert_response :success
  end
end
