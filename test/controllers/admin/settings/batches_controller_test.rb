require "test_helper"

class Admin::Settings::BatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_settings_batches_path
    assert_response :success
  end

  test "should get bulk_add_remarks" do
    get bulk_add_remarks_admin_settings_batches_path
    assert_response :success
  end

  test "should get bulk_temporary_delete" do
    get bulk_temporary_delete_admin_settings_batches_path
    assert_response :success
  end

  test "should get bulk_change_assignee" do
    get bulk_change_assignee_admin_settings_batches_path
    assert_response :success
  end

  test "should get calculate_registration_ratio" do
    get calculate_registration_ratio_admin_settings_batches_path
    assert_response :success
  end

  test "should get calculate_rotation_rate" do
    get calculate_rotation_rate_admin_settings_batches_path
    assert_response :success
  end
end
