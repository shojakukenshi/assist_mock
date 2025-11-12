require "test_helper"

class Admin::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_projects_path
    assert_response :success
  end

  test "index page should have detail pane for slide-in" do
    get admin_projects_path
    assert_response :success
    assert_select '[data-project-detail-target="pane"]', 1, "Detail pane should exist for project details"
  end

  test "should get staff matching page" do
    get staff_matching_admin_project_path(id: 1)
    assert_response :success
    assert_select 'h1', text: "AIスタッフマッチング"
  end

  test "staff matching should display matched staff" do
    get staff_matching_admin_project_path(id: 1)
    assert_response :success
    assert_select 'input[type="checkbox"][name="staff_ids[]"]', minimum: 1
  end

  test "should post send recruitment" do
    post send_recruitment_admin_project_path(id: 1), params: {
      staff_ids: [1, 2],
      message: "ぜひご参加ください"
    }
    assert_redirected_to admin_projects_path
    assert_equal "2名のスタッフに募集メールを送信しました。", flash[:success]
  end
end
