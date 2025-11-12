require "test_helper"

class Admin::Sales::PipelineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_sales_pipeline_path
    assert_response :success
  end

  test "should display kanban board with 5 stages" do
    get admin_sales_pipeline_path
    assert_response :success
    assert_select 'h3', text: '商談中', minimum: 1
    assert_select 'h3', text: '見積提出', minimum: 1
    assert_select 'h3', text: '確定/手配中', minimum: 1
    assert_select 'h3', text: '進行中', minimum: 1
    assert_select 'h3', text: '完了', minimum: 1
  end

  test "should show event-specific information in cards" do
    get admin_sales_pipeline_path
    assert_response :success
    # Check for venue icons
    assert_select 'svg', minimum: 1
  end
end
