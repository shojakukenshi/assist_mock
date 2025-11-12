class Admin::Staffing::AssignmentsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "手配管理", path: admin_staffing_assignments_path },
      { name: "スタッフ配置", path: admin_staffing_assignments_path }
    ]

    # KPIサマリー
    @summary = {
      total_projects: 35,
      matching_in_progress: 8,
      assigned_this_month: 12,
      avg_matching_score: 87.5,
      avg_assignment_days: 3.2
    }

    # 配置待ち案件一覧
    @projects = [
      {
        id: 1,
        project_code: "PJ-2025-001",
        project_name: "H社 ECサイトリニューアル",
        client_name: "H株式会社",
        required_skills: ["PHP", "Laravel", "Vue.js"],
        skill_level: "中級以上",
        start_date: "2025-12-01",
        end_date: "2026-03-31",
        required_count: 2,
        assigned_count: 0,
        hourly_budget: 4500,
        location: "東京都（リモート可）",
        status: "募集中",
        priority: "高",
        deadline: "2025-11-20",
        remarks: "リモート週3日可"
      },
      {
        id: 2,
        project_code: "PJ-2025-002",
        project_name: "I社 基幹システム保守",
        client_name: "I株式会社",
        required_skills: ["Java", "Spring", "Oracle"],
        skill_level: "上級",
        start_date: "2025-11-25",
        end_date: "2026-11-30",
        required_count: 1,
        assigned_count: 0,
        hourly_budget: 5200,
        location: "神奈川県",
        status: "募集中",
        priority: "高",
        deadline: "2025-11-18",
        remarks: "即日アサイン希望"
      },
      {
        id: 3,
        project_code: "PJ-2025-003",
        project_name: "J社 データ分析基盤構築",
        client_name: "J株式会社",
        required_skills: ["Python", "AWS", "BigQuery"],
        skill_level: "中級以上",
        start_date: "2025-12-15",
        end_date: "2026-06-30",
        required_count: 3,
        assigned_count: 1,
        hourly_budget: 5000,
        location: "東京都",
        status: "募集中",
        priority: "中",
        deadline: "2025-12-01",
        remarks: "1名確定済、残り2名募集"
      },
      {
        id: 4,
        project_code: "PJ-2025-004",
        project_name: "K社 モバイルアプリ開発",
        client_name: "K株式会社",
        required_skills: ["Swift", "iOS", "Firebase"],
        skill_level: "中級",
        start_date: "2026-01-10",
        end_date: "2026-05-31",
        required_count: 2,
        assigned_count: 0,
        hourly_budget: 4300,
        location: "千葉県（リモート可）",
        status: "募集中",
        priority: "中",
        deadline: "2025-12-20",
        remarks: "フルリモート可"
      },
      {
        id: 5,
        project_code: "PJ-2025-005",
        project_name: "L社 インフラ刷新プロジェクト",
        client_name: "L株式会社",
        required_skills: ["AWS", "Docker", "Kubernetes"],
        skill_level: "上級",
        start_date: "2025-12-01",
        end_date: "2026-08-31",
        required_count: 2,
        assigned_count: 1,
        hourly_budget: 5500,
        location: "東京都",
        status: "募集中",
        priority: "高",
        deadline: "2025-11-22",
        remarks: "1名確定済"
      }
    ]

    # AIマッチング候補（案件ID: 1 - H社 ECサイトリニューアル用）
    @matching_candidates = [
      {
        staff_id: 2,
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        skills: ["PHP", "Laravel", "Vue.js"],
        skill_level: "中級",
        hourly_rate: 4000,
        location: "神奈川県",
        work_status: "稼働中",
        availability_date: nil,
        current_project_end: "2025-11-30",
        rating: 4.5,
        assignment_count: 8,
        matching_score: 95,
        match_reasons: [
          "必須スキル完全一致",
          "スキルレベル適合",
          "稼働終了日が開始日直前",
          "評価4.5以上"
        ],
        concerns: []
      },
      {
        staff_id: 6,
        staff_code: "ST-0006",
        staff_name: "伊藤里奈",
        skills: ["Ruby", "Rails", "PostgreSQL"],
        skill_level: "中級",
        hourly_rate: 4200,
        location: "埼玉県",
        work_status: "待機中",
        availability_date: "2025-11-20",
        current_project_end: nil,
        rating: 4.4,
        assignment_count: 10,
        matching_score: 72,
        match_reasons: [
          "Webアプリケーション経験豊富",
          "スキルレベル適合",
          "即日稼働可能",
          "長期案件希望とマッチ"
        ],
        concerns: [
          "PHP/Laravel経験なし",
          "スキル転換が必要"
        ]
      },
      {
        staff_id: 9,
        staff_code: "ST-0009",
        staff_name: "中村健",
        skills: ["Go", "gRPC", "Redis"],
        skill_level: "初級",
        hourly_rate: 3500,
        location: "東京都",
        work_status: "待機中",
        availability_date: "即日",
        current_project_end: nil,
        rating: 4.2,
        assignment_count: 3,
        matching_score: 58,
        match_reasons: [
          "バックエンド開発経験あり",
          "即日稼働可能",
          "予算内の単価"
        ],
        concerns: [
          "必須スキル未経験",
          "スキルレベル不足",
          "アサイン実績が少ない"
        ]
      }
    ]

    # 配置履歴
    @assignment_history = [
      {
        id: 1,
        assignment_date: "2025-11-10",
        project_name: "M社システム開発",
        staff_name: "山本太郎",
        start_date: "2025-11-15",
        matching_score: 92,
        status: "稼働中"
      },
      {
        id: 2,
        assignment_date: "2025-11-08",
        project_name: "N社Webサイト構築",
        staff_name: "佐藤美咲",
        start_date: "2025-11-12",
        matching_score: 88,
        status: "稼働中"
      },
      {
        id: 3,
        assignment_date: "2025-11-05",
        project_name: "O社インフラ構築",
        staff_name: "高橋健太",
        start_date: "2025-11-10",
        matching_score: 95,
        status: "稼働中"
      },
      {
        id: 4,
        assignment_date: "2025-11-01",
        project_name: "P社ECサイト開発",
        staff_name: "渡辺翔太",
        start_date: "2025-11-05",
        matching_score: 90,
        status: "稼働中"
      },
      {
        id: 5,
        assignment_date: "2025-10-28",
        project_name: "Q社モバイルアプリ開発",
        staff_name: "松本愛",
        start_date: "2025-11-01",
        matching_score: 93,
        status: "稼働中"
      }
    ]

    # マッチング成功率推移
    @matching_trends = [
      { month: "2025-06", total: 15, success: 14, rate: 93.3 },
      { month: "2025-07", total: 18, success: 17, rate: 94.4 },
      { month: "2025-08", total: 12, success: 11, rate: 91.7 },
      { month: "2025-09", total: 16, success: 15, rate: 93.8 },
      { month: "2025-10", total: 14, success: 13, rate: 92.9 },
      { month: "2025-11", total: 12, success: 12, rate: 100.0 }
    ]
  end
end
