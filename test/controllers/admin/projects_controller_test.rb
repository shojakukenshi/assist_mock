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
end
