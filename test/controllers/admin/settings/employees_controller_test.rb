require "test_helper"

class Admin::Settings::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_employees_path
    assert_response :success
  end

  test "should display employee list" do
    get admin_settings_employees_path
    assert_response :success
    assert_select 'h1', text: /社員管理/, minimum: 0
  end

  test "should get new" do
    get new_admin_settings_employee_path
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_settings_employee_path(id: 1)
    assert_response :success
  end

  test "should get show" do
    get admin_settings_employee_path(id: 1)
    assert_response :success
  end
end
