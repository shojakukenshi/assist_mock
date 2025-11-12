class Admin::Settings::Mypage::AnalyticsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_mypage_path },
      { name: "マイページ", path: admin_settings_mypage_path },
      { name: "アクセス解析", path: admin_settings_mypage_analytics_path }
    ]

    # 日別アクセス数（直近30日）
    @daily_access = (0...30).map do |i|
      date = Date.today - i.days
      {
        date: date.strftime("%Y-%m-%d"),
        total_access: rand(80..150),
        unique_users: rand(40..85),
        page_views: rand(200..400)
      }
    end.reverse

    # 時間帯別アクセス数
    @hourly_access = (0..23).map do |hour|
      {
        hour: hour,
        access_count: case hour
                      when 6..9 then rand(15..35)    # 朝
                      when 12..14 then rand(10..25)  # 昼
                      when 18..21 then rand(20..45)  # 夜
                      else rand(2..10)               # その他
                      end
      }
    end

    # ページ別アクセスランキング
    @page_ranking = [
      { page: "マイページトップ", path: "/mypage", access_count: 2_450, unique_users: 142 },
      { page: "勤怠入力", path: "/mypage/attendances", access_count: 1_820, unique_users: 128 },
      { page: "給与明細", path: "/mypage/payslips", access_count: 1_560, unique_users: 135 },
      { page: "案件応募", path: "/mypage/applications", access_count: 980, unique_users: 85 },
      { page: "シフト確認", path: "/mypage/schedules", access_count: 850, unique_users: 92 },
      { page: "メッセージ", path: "/mypage/messages", access_count: 720, unique_users: 68 },
      { page: "プロフィール編集", path: "/mypage/profile", access_count: 420, unique_users: 58 },
      { page: "スキル登録", path: "/mypage/skills", access_count: 350, unique_users: 42 },
      { page: "FAQ", path: "/mypage/faq", access_count: 280, unique_users: 65 },
      { page: "お問い合わせ", path: "/mypage/contact", access_count: 180, unique_users: 38 }
    ]

    # デバイス別アクセス
    @device_breakdown = [
      { device: "スマートフォン", count: 4_820, percentage: 68.5 },
      { device: "PC", count: 1_850, percentage: 26.3 },
      { device: "タブレット", count: 365, percentage: 5.2 }
    ]

    # OS別アクセス
    @os_breakdown = [
      { os: "iOS", count: 2_850, percentage: 40.5 },
      { os: "Android", count: 2_120, percentage: 30.1 },
      { os: "Windows", count: 1_450, percentage: 20.6 },
      { os: "Mac", count: 520, percentage: 7.4 },
      { os: "その他", count: 95, percentage: 1.4 }
    ]

    # ブラウザ別アクセス
    @browser_breakdown = [
      { browser: "Chrome", count: 3_650, percentage: 51.8 },
      { browser: "Safari", count: 2_420, percentage: 34.4 },
      { browser: "Edge", count: 580, percentage: 8.2 },
      { browser: "Firefox", count: 285, percentage: 4.0 },
      { browser: "その他", count: 100, percentage: 1.4 }
    ]

    # アクティブユーザー推移（月別）
    @monthly_active_users = [
      { month: "2025-06", total: 145, daily_avg: 98, weekly_avg: 125 },
      { month: "2025-07", total: 150, daily_avg: 102, weekly_avg: 128 },
      { month: "2025-08", total: 155, daily_avg: 105, weekly_avg: 132 },
      { month: "2025-09", total: 160, daily_avg: 110, weekly_avg: 138 },
      { month: "2025-10", total: 165, daily_avg: 115, weekly_avg: 142 },
      { month: "2025-11", total: 170, daily_avg: 118, weekly_avg: 145 }
    ]

    # サマリー
    @summary = {
      total_access_today: 142,
      total_access_this_week: 856,
      total_access_this_month: 3_650,
      unique_users_today: 85,
      unique_users_this_week: 128,
      unique_users_this_month: 158,
      avg_session_duration: "4分32秒",
      bounce_rate: 12.5
    }
  end
end
