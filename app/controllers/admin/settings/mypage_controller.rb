class Admin::Settings::MypageController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_mypage_path },
      { name: "マイページ", path: admin_settings_mypage_path }
    ]

    # マイページメニュー
    @mypage_menu = [
      {
        id: "analytics",
        name: "アクセス解析",
        description: "スタッフのマイページアクセス状況",
        icon: "📊",
        path: admin_settings_mypage_analytics_path
      },
      {
        id: "messages",
        name: "マイページメッセージ一覧",
        description: "スタッフ向けお知らせメッセージの管理",
        icon: "📨",
        path: admin_settings_mypage_messages_path
      }
    ]

    # 最近のアクティビティ
    @recent_activities = [
      { type: "access", staff_name: "山本太郎", action: "マイページログイン", timestamp: "2025-11-12 09:30" },
      { type: "message", staff_name: "システム", action: "新着メッセージ配信：12月繁忙期のお知らせ", timestamp: "2025-11-12 09:00" },
      { type: "access", staff_name: "鈴木花子", action: "勤怠入力", timestamp: "2025-11-12 08:45" },
      { type: "access", staff_name: "田中一郎", action: "給与明細確認", timestamp: "2025-11-11 18:20" },
      { type: "message", staff_name: "システム", action: "新着メッセージ配信：安全衛生講習のご案内", timestamp: "2025-11-11 10:00" }
    ]

    # サマリー
    @summary = {
      total_staff: 158,
      logged_in_today: 42,
      logged_in_this_week: 128,
      unread_messages: 256,
      pending_approvals: 18
    }
  end
end
