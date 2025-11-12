require "test_helper"

class Admin::Settings::Mypage::MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_mypage_messages_path
    assert_response :success
  end

  test "should get edit_message" do
    get admin_settings_mypage_edit_message_path
    assert_response :success
  end

  test "should display message list" do
    get admin_settings_mypage_messages_path
    assert_response :success
    assert_select 'h1', text: /マイページメッセージ/, minimum: 0
  end
end
