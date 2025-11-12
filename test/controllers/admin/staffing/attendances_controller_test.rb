require "test_helper"

class Admin::Staffing::AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffing_attendances_path
    assert_response :success
  end

  test "index page should have detail panel for slide-in" do
    get admin_staffing_attendances_path
    assert_response :success
    assert_select '[data-attendance-detail-target="panel"]', 1, "Detail panel should exist for attendance details"
  end

  test "calendar view should display month and year" do
    get admin_staffing_attendances_path(year: 2025, month: 11)
    assert_response :success
    assert_select 'h2', text: /2025年 11月/
  end

  test "calendar should show day of week headers" do
    get admin_staffing_attendances_path
    assert_response :success
    %w[日 月 火 水 木 金 土].each do |day|
      assert_select '.text-sm.font-bold', text: day, minimum: 1
    end
  end

  test "calendar should display daily statistics labels" do
    get admin_staffing_attendances_path
    assert_response :success
    assert_select '.text-gray-500', text: '予定:', minimum: 1
    assert_select '.text-gray-500', text: '稼働:', minimum: 1
  end

  test "calendar should have month navigation links" do
    get admin_staffing_attendances_path(year: 2025, month: 11)
    assert_response :success
    # Previous month link
    assert_select 'a[href*="year=2025"][href*="month=10"]', minimum: 1
    # Next month link
    assert_select 'a[href*="year=2025"][href*="month=12"]', minimum: 1
    # Today button
    assert_select 'a', text: '今月', minimum: 1
  end

  test "selected date should show detail table" do
    get admin_staffing_attendances_path(year: 2025, month: 11, date: "2025-11-11")
    assert_response :success
    assert_select 'h2', text: /の勤怠詳細/, minimum: 1
    assert_select 'table thead th', text: 'スタッフ', minimum: 1
    assert_select 'table thead th', text: '勤務形態', minimum: 1
    assert_select 'a', text: 'カレンダーに戻る', minimum: 1
  end

  test "calendar view should show KPI cards" do
    get admin_staffing_attendances_path
    assert_response :success
    assert_select '.text-xs.font-medium', text: '総件数', minimum: 1
    assert_select '.text-xs.font-medium', text: '未承認', minimum: 1
    assert_select '.text-xs.font-medium', text: '今月承認済', minimum: 1
    assert_select '.text-xs.font-medium', text: '異常検知', minimum: 1
  end
end
