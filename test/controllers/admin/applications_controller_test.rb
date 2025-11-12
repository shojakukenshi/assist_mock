require "test_helper"

class Admin::ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get applications index" do
    get admin_project_applications_path(project_id: 1)
    assert_response :success
  end

  test "should get application show" do
    get admin_project_application_path(project_id: 1, id: 1)
    assert_response :success
  end

  test "should post accept application" do
    post accept_admin_project_application_path(project_id: 1, id: 1), params: {
      role: "バックエンドエンジニア",
      responsibilities: "API開発",
      start_date: "2025-01-15",
      end_date: "2025-06-30",
      unit_price: 850000
    }
    assert_redirected_to admin_projects_path
    assert_equal "山田太郎さんの配置を確定しました。", flash[:success]
  end

  test "should post reject application" do
    post reject_admin_project_application_path(project_id: 1, id: 1), params: {
      reject_reason: "スキルセットが合いませんでした"
    }
    assert_redirected_to admin_project_applications_path(project_id: 1)
    assert_equal "山田太郎さんの応募をお断りしました。", flash[:success]
  end
end
