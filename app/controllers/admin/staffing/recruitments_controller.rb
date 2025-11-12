class Admin::Staffing::RecruitmentsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "手配管理", path: admin_staffing_recruitments_path },
      { name: "採用管理", path: admin_staffing_recruitments_path }
    ]

    # 全応募者データ
    all_applicants = [
      {
        id: 1,
        name: "山田太郎",
        age: 28,
        gender: "男性",
        phone: "090-1234-5678",
        email: "yamada@example.com",
        applied_date: "2025-11-05",
        position: "システムエンジニア",
        experience_years: 5,
        status: "アプリ面接",
        progress: 60,
        skills: ["Ruby", "Rails", "JavaScript"],
        interview_count: 2,
        last_interview_date: "2025-11-10",
        next_action: "最終面接調整中",
        referral_source: "求人サイトA"
      },
      {
        id: 2,
        name: "佐藤花子",
        age: 25,
        gender: "女性",
        phone: "080-2345-6789",
        email: "sato@example.com",
        applied_date: "2025-11-08",
        position: "Webデザイナー",
        experience_years: 3,
        status: "アプリ合格",
        progress: 40,
        skills: ["Photoshop", "Illustrator", "Figma"],
        interview_count: 1,
        last_interview_date: "2025-11-12",
        next_action: "結果待ち",
        referral_source: "求人サイトB"
      },
      {
        id: 3,
        name: "鈴木一郎",
        age: 32,
        gender: "男性",
        phone: "090-3456-7890",
        email: "suzuki@example.com",
        applied_date: "2025-11-01",
        position: "プロジェクトマネージャー",
        experience_years: 8,
        status: "採用",
        progress: 100,
        skills: ["PMI", "Agile", "Scrum"],
        interview_count: 3,
        last_interview_date: "2025-11-15",
        next_action: "入社手続き中",
        referral_source: "紹介"
      },
      {
        id: 4,
        name: "田中美咲",
        age: 23,
        gender: "女性",
        phone: "080-4567-8901",
        email: "tanaka@example.com",
        applied_date: "2025-11-10",
        position: "営業アシスタント",
        experience_years: 1,
        status: "アプリ応募",
        progress: 20,
        skills: ["Excel", "PowerPoint", "Word"],
        interview_count: 0,
        last_interview_date: nil,
        next_action: "書類審査中",
        referral_source: "求人サイトA"
      },
      {
        id: 5,
        name: "高橋健太",
        age: 29,
        gender: "男性",
        phone: "090-5678-9012",
        email: "takahashi@example.com",
        applied_date: "2025-11-03",
        position: "インフラエンジニア",
        experience_years: 6,
        status: "アプリ面接",
        progress: 80,
        skills: ["AWS", "Docker", "Kubernetes"],
        interview_count: 3,
        last_interview_date: "2025-11-18",
        next_action: "合否判定中",
        referral_source: "リファラル"
      },
      {
        id: 6,
        name: "伊藤真由美",
        age: 27,
        gender: "女性",
        phone: "080-6789-0123",
        email: "ito@example.com",
        applied_date: "2025-10-28",
        position: "経理スタッフ",
        experience_years: 4,
        status: "不合格",
        progress: 0,
        skills: ["簿記2級", "弥生会計", "Excel"],
        interview_count: 1,
        last_interview_date: "2025-11-01",
        next_action: "-",
        referral_source: "求人サイトC"
      },
      {
        id: 7,
        name: "渡辺翔太",
        age: 26,
        gender: "男性",
        phone: "090-7890-1234",
        email: "watanabe@example.com",
        applied_date: "2025-11-12",
        position: "フロントエンドエンジニア",
        experience_years: 3,
        status: "アプリ合格",
        progress: 40,
        skills: ["React", "Vue.js", "TypeScript"],
        interview_count: 1,
        last_interview_date: "2025-11-20",
        next_action: "次回面接調整中",
        referral_source: "求人サイトA"
      },
      {
        id: 8,
        name: "小林由美",
        age: 31,
        gender: "女性",
        phone: "080-8901-2345",
        email: "kobayashi@example.com",
        applied_date: "2025-11-06",
        position: "人事担当",
        experience_years: 7,
        status: "アプリ面接",
        progress: 60,
        skills: ["採用業務", "労務管理", "給与計算"],
        interview_count: 2,
        last_interview_date: "2025-11-14",
        next_action: "最終面接調整中",
        referral_source: "紹介"
      },
      {
        id: 9,
        name: "中村健",
        age: 24,
        gender: "男性",
        phone: "090-9012-3456",
        email: "nakamura@example.com",
        applied_date: "2025-11-11",
        position: "カスタマーサポート",
        experience_years: 2,
        status: "アプリ応募",
        progress: 20,
        skills: ["コミュニケーション", "Salesforce", "Zendesk"],
        interview_count: 0,
        last_interview_date: nil,
        next_action: "書類審査中",
        referral_source: "求人サイトB"
      },
      {
        id: 10,
        name: "加藤里奈",
        age: 30,
        gender: "女性",
        phone: "080-0123-4567",
        email: "kato@example.com",
        applied_date: "2025-11-04",
        position: "マーケティング担当",
        experience_years: 6,
        status: "採用",
        progress: 100,
        skills: ["SEO", "Google Analytics", "SNS運用"],
        interview_count: 3,
        last_interview_date: "2025-11-17",
        next_action: "入社手続き中",
        referral_source: "リファラル"
      },
      {
        id: 11,
        name: "吉田大輔",
        age: 27,
        gender: "男性",
        phone: "090-1111-2222",
        email: "yoshida@example.com",
        applied_date: "2025-11-09",
        position: "データアナリスト",
        experience_years: 4,
        status: "保留",
        progress: 40,
        skills: ["Python", "SQL", "Tableau"],
        interview_count: 1,
        last_interview_date: "2025-11-19",
        next_action: "追加検討中",
        referral_source: "求人サイトA"
      },
      {
        id: 12,
        name: "松本愛",
        age: 25,
        gender: "女性",
        phone: "080-2222-3333",
        email: "matsumoto@example.com",
        applied_date: "2025-11-07",
        position: "総務スタッフ",
        experience_years: 3,
        status: "アプリ面接",
        progress: 60,
        skills: ["庶務", "備品管理", "社内イベント"],
        interview_count: 2,
        last_interview_date: "2025-11-16",
        next_action: "最終面接予定",
        referral_source: "求人サイトC"
      },
      {
        id: 13,
        name: "森田和也",
        age: 29,
        gender: "男性",
        phone: "090-3333-4444",
        email: "morita@example.com",
        applied_date: "2025-11-13",
        position: "営業担当",
        experience_years: 5,
        status: "保留",
        progress: 30,
        skills: ["営業", "提案", "プレゼン"],
        interview_count: 1,
        last_interview_date: "2025-11-21",
        next_action: "再検討中",
        referral_source: "求人サイトB"
      },
      {
        id: 14,
        name: "岡田麻衣",
        age: 26,
        gender: "女性",
        phone: "080-4444-5555",
        email: "okada@example.com",
        applied_date: "2025-11-14",
        position: "デザイナー",
        experience_years: 4,
        status: "不合格",
        progress: 0,
        skills: ["UI/UX", "Sketch", "Adobe XD"],
        interview_count: 1,
        last_interview_date: "2025-11-22",
        next_action: "-",
        referral_source: "求人サイトA"
      },
      {
        id: 15,
        name: "橋本健",
        age: 31,
        gender: "男性",
        phone: "090-5555-6666",
        email: "hashimoto@example.com",
        applied_date: "2025-11-15",
        position: "エンジニア",
        experience_years: 7,
        status: "採用",
        progress: 100,
        skills: ["Java", "Spring Boot", "AWS"],
        interview_count: 3,
        last_interview_date: "2025-11-23",
        next_action: "入社準備中",
        referral_source: "リファラル"
      }
    ]

    # ステータスでフィルタリング
    @selected_status = params[:status]
    @applicants = if @selected_status.present?
                    all_applicants.select { |a| a[:status] == @selected_status }
                  else
                    all_applicants
                  end

    # ステータス別集計（全データから計算）
    @status_summary = [
      { status: "アプリ応募", count: all_applicants.count { |a| a[:status] == "アプリ応募" }, color: "gray" },
      { status: "アプリ合格", count: all_applicants.count { |a| a[:status] == "アプリ合格" }, color: "blue" },
      { status: "アプリ面接", count: all_applicants.count { |a| a[:status] == "アプリ面接" }, color: "yellow" },
      { status: "採用", count: all_applicants.count { |a| a[:status] == "採用" }, color: "green" },
      { status: "不合格", count: all_applicants.count { |a| a[:status] == "不合格" }, color: "red" },
      { status: "保留", count: all_applicants.count { |a| a[:status] == "保留" }, color: "orange" }
    ]

    # KPIサマリー
    @summary = {
      total_applicants: all_applicants.count,
      in_interview: all_applicants.count { |a| ["アプリ合格", "アプリ面接"].include?(a[:status]) },
      offers_sent: all_applicants.count { |a| a[:status] == "採用" },
      hired_this_month: all_applicants.count { |a| a[:status] == "採用" },
      conversion_rate: (all_applicants.count { |a| a[:status] == "採用" }.to_f / all_applicants.count * 100).round(1)
    }

    # 月次採用状況推移
    @monthly_trends = [
      { month: "2025-06", applicants: 38, interviewed: 28, hired: 6 },
      { month: "2025-07", applicants: 42, interviewed: 32, hired: 7 },
      { month: "2025-08", applicants: 35, interviewed: 26, hired: 5 },
      { month: "2025-09", applicants: 40, interviewed: 30, hired: 6 },
      { month: "2025-10", applicants: 45, interviewed: 35, hired: 8 },
      { month: "2025-11", applicants: 45, interviewed: 33, hired: 8 }
    ]
  end
end
