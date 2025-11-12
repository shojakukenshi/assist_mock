require "test_helper"

class Admin::Settings::MastersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_masters_path
    assert_response :success
  end

  test "should get belongings" do
    get belongings_admin_settings_masters_path
    assert_response :success
  end

  test "should get appearance" do
    get appearance_admin_settings_masters_path
    assert_response :success
  end

  test "should get ip_addresses" do
    get ip_addresses_admin_settings_masters_path
    assert_response :success
  end

  test "should get notification_emails" do
    get notification_emails_admin_settings_masters_path
    assert_response :success
  end

  test "should get salary_tables" do
    get salary_tables_admin_settings_masters_path
    assert_response :success
  end

  test "should get mynumber_purposes" do
    get mynumber_purposes_admin_settings_masters_path
    assert_response :success
  end
end
