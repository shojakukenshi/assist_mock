require "test_helper"

class Admin::ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_clients_path
    assert_response :success
  end

  test "index page should have detail pane for slide-in" do
    get admin_clients_path
    assert_response :success
    assert_select '[data-client-detail-target="pane"]', 1, "Detail pane should exist for client details"
  end
end
