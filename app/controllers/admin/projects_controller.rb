class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:staff_matching, :send_recruitment]

  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path }
    ]

    # ステータス定義
    @statuses = ["商談中", "見積提出", "確定/手配中", "進行中", "完了"]

    # 応募通知（モックデータ）
    @pending_applications = [
      { id: 1, project_id: 1, project_name: "東京モーターショー2025", staff_name: "山田太郎", staff_id: 1, applied_at: "2025-11-10 10:30", status: "pending" },
      { id: 2, project_id: 4, project_name: "企業展示会サポート", staff_name: "佐藤次郎", staff_id: 2, applied_at: "2025-11-11 14:20", status: "pending" },
      { id: 3, project_id: 11, project_name: "音楽フェスティバル運営", staff_name: "鈴木花子", staff_id: 3, applied_at: "2025-11-12 09:15", status: "pending" }
    ]

    # フィルタオプション
    @filters = {
      statuses: @statuses,
      sales_reps: ["佐藤花子", "田中次郎", "伊藤健太", "鈴木美咲"],
      industries: ["展示会・見本市", "コンサート・ライブ", "スポーツイベント", "企業イベント", "結婚式・パーティー", "セミナー・講演会", "その他"]
    }

    # KPI集計
    @summary = {
      total_projects: 24,
      negotiating: 6,
      estimating: 5,
      arranging: 7,
      in_progress: 3,
      completed: 3,
      total_value: 48_500_000,
      monthly_revenue: 8_750_000,
      success_rate: 85.0
    }

    # イベントスタッフ派遣案件データ
    @projects = [
      {
        id: 1,
        name: "東京モーターショー2025",
        client_name: "日本自動車工業会",
        client_id: 1,
        status: "確定/手配中",
        sales_rep: "佐藤花子",
        amount: 8_500_000,
        start_date: "2025-11-15",
        end_date: "2025-11-24",
        event_date: "2025-11-20～11-24",
        staff_count: 50,
        daily_rate: 15_000,
        days: 5,
        probability: 100,
        industry: "展示会・見本市",
        last_updated: "2025-11-10",
        tags: ["大規模", "VIP対応"],
        description: "モーターショー会場での受付・誘導・通訳スタッフ派遣。英語対応可能者20名必須。",
        contact_name: "田中一郎",
        contact_email: "tanaka@jama.or.jp",
        contact_phone: "03-1234-5678",
        venue: "東京ビッグサイト",
        required_skills: ["接客経験", "英語", "イベント経験"],
        uniform: "指定あり",
        work_hours: "09:00-18:00"
      },
      {
        id: 2,
        name: "年末チャリティーコンサート",
        client_name: "株式会社ミュージックプロモーション",
        client_id: 2,
        status: "見積提出",
        sales_rep: "田中次郎",
        amount: 2_800_000,
        start_date: "2025-12-20",
        end_date: "2025-12-20",
        event_date: "2025-12-20",
        staff_count: 30,
        daily_rate: 12_000,
        days: 1,
        probability: 70,
        industry: "コンサート・ライブ",
        last_updated: "2025-11-11",
        tags: ["夜間", "音楽"],
        description: "大型コンサートホールでの観客誘導・グッズ販売・警備補助スタッフ。",
        contact_name: "山本花子",
        contact_email: "yamamoto@musicpro.co.jp",
        contact_phone: "03-2345-6789",
        venue: "東京国際フォーラム",
        required_skills: ["接客経験", "体力"],
        uniform: "貸与",
        work_hours: "14:00-22:00"
      },
      {
        id: 3,
        name: "企業周年記念パーティー",
        client_name: "グローバルコーポレーション株式会社",
        client_id: 3,
        status: "商談中",
        sales_rep: "佐藤花子",
        amount: 1_200_000,
        start_date: "2026-01-25",
        end_date: "2026-01-25",
        event_date: "2026-01-25",
        staff_count: 15,
        daily_rate: 18_000,
        days: 1,
        probability: 60,
        industry: "企業イベント",
        last_updated: "2025-11-09",
        tags: ["フォーマル", "高単価"],
        description: "創立50周年記念パーティーでの受付・クローク・配膳サポート。正装必須。",
        contact_name: "高橋太郎",
        contact_email: "takahashi@global-corp.co.jp",
        contact_phone: "03-3456-7890",
        venue: "帝国ホテル",
        required_skills: ["接客経験", "フォーマル対応"],
        uniform: "正装（持参）",
        work_hours: "17:00-22:00"
      },
      {
        id: 4,
        name: "企業展示会サポート",
        client_name: "テクノロジーエキスポ運営委員会",
        client_id: 4,
        status: "進行中",
        sales_rep: "伊藤健太",
        amount: 6_500_000,
        start_date: "2025-11-13",
        end_date: "2025-11-15",
        event_date: "2025-11-13～11-15",
        staff_count: 40,
        daily_rate: 14_000,
        days: 3,
        probability: 100,
        industry: "展示会・見本市",
        last_updated: "2025-11-12",
        tags: ["進行中", "IT業界"],
        description: "IT関連展示会でのブース対応・受付・技術説明補助スタッフ。",
        contact_name: "渡辺次郎",
        contact_email: "watanabe@techexpo.co.jp",
        contact_phone: "03-4567-8901",
        venue: "幕張メッセ",
        required_skills: ["IT知識", "接客経験"],
        uniform: "指定あり",
        work_hours: "09:00-17:00"
      },
      {
        id: 5,
        name: "マラソン大会運営サポート",
        client_name: "東京マラソン実行委員会",
        client_id: 5,
        status: "完了",
        sales_rep: "鈴木美咲",
        amount: 4_800_000,
        start_date: "2024-10-15",
        end_date: "2024-10-15",
        event_date: "2024-10-15",
        staff_count: 80,
        daily_rate: 10_000,
        days: 1,
        probability: 100,
        industry: "スポーツイベント",
        last_updated: "2024-10-16",
        tags: ["大規模", "屋外"],
        description: "マラソン大会の給水所・誘導・荷物預かり所スタッフ。早朝勤務あり。",
        contact_name: "中村健太",
        contact_email: "nakamura@tokyomarathon.jp",
        contact_phone: "03-5678-9012",
        venue: "都内各所",
        required_skills: ["体力", "早朝勤務可"],
        uniform: "貸与",
        work_hours: "06:00-14:00"
      },
      {
        id: 6,
        name: "音楽フェスティバル運営",
        client_name: "フェスティバルプロダクション株式会社",
        client_id: 6,
        status: "商談中",
        sales_rep: "田中次郎",
        amount: 6_000_000,
        start_date: "2025-01-01",
        end_date: "2025-12-31",
        staff_count: 1,
        unit_price: 500_000,
        months: 12,
        probability: 100,
        industry: "金融",
        last_updated: "2025-11-08",
        tags: ["保守"],
        description: "既存基幹システムの運用保守・機能追加",
        contact_name: "小林太郎",
        contact_email: "kobayashi@enterprise.co.jp",
        contact_phone: "03-6789-0123"
      },
      {
        id: 7,
        name: "クラウド移行支援",
        client_name: "株式会社レガシーシステムズ",
        client_id: 2,
        status: "商談中",
        sales_rep: "佐藤花子",
        amount: 18_000_000,
        start_date: "2025-04-01",
        end_date: "2025-09-30",
        staff_count: 3,
        unit_price: 950_000,
        months: 6,
        probability: 60,
        industry: "製造業",
        last_updated: "2025-11-11",
        tags: ["クラウド", "大型案件"],
        description: "オンプレミスシステムのAWS移行プロジェクト",
        contact_name: "加藤一郎",
        contact_email: "kato@legacy-sys.co.jp",
        contact_phone: "03-7890-1234"
      },
      {
        id: 8,
        name: "AIチャットボット導入",
        client_name: "株式会社カスタマーサポート",
        client_id: 3,
        status: "見積中",
        sales_rep: "伊藤健太",
        amount: 7_500_000,
        start_date: "2025-02-15",
        end_date: "2025-05-31",
        staff_count: 2,
        unit_price: 850_000,
        months: 4,
        probability: 65,
        industry: "サービス",
        last_updated: "2025-11-10",
        tags: ["AI", "新技術"],
        description: "OpenAI APIを活用したカスタマーサポート用チャットボット",
        contact_name: "吉田花子",
        contact_email: "yoshida@customer-support.co.jp",
        contact_phone: "03-8901-2345"
      },
      {
        id: 9,
        name: "業務自動化RPA導入",
        client_name: "株式会社オートメーション",
        client_id: 1,
        status: "失注",
        sales_rep: "鈴木美咲",
        amount: 5_000_000,
        start_date: nil,
        end_date: nil,
        staff_count: 1,
        unit_price: 700_000,
        months: 6,
        probability: 0,
        industry: "IT・通信",
        last_updated: "2025-10-20",
        tags: ["失注理由: 予算"],
        description: "経理・総務業務の自動化",
        contact_name: "山本太郎",
        contact_email: "yamamoto@automation.co.jp",
        contact_phone: "03-9012-3456"
      },
      {
        id: 10,
        name: "Webサイト制作",
        client_name: "株式会社スタートアップ",
        client_id: 4,
        status: "商談中",
        sales_rep: "田中次郎",
        amount: 2_800_000,
        start_date: "2025-02-01",
        end_date: "2025-03-31",
        staff_count: 2,
        unit_price: 700_000,
        months: 2,
        probability: 40,
        industry: "IT・通信",
        last_updated: "2025-11-07",
        tags: ["小規模"],
        description: "コーポレートサイトの新規制作",
        contact_name: "佐々木次郎",
        contact_email: "sasaki@startup.co.jp",
        contact_phone: "03-0123-4567"
      },
      {
        id: 11,
        name: "SaaS開発プロジェクト",
        client_name: "株式会社イノベーション",
        client_id: 5,
        status: "確定",
        sales_rep: "佐藤花子",
        amount: 25_000_000,
        start_date: "2025-02-01",
        end_date: "2025-12-31",
        staff_count: 5,
        unit_price: 950_000,
        months: 10,
        probability: 100,
        industry: "IT・通信",
        last_updated: "2025-11-12",
        tags: ["重要", "大型案件", "新規"],
        description: "BtoB向けSaaSプロダクトの新規開発",
        contact_name: "林美咲",
        contact_email: "hayashi@innovation.co.jp",
        contact_phone: "03-1122-3344"
      },
      {
        id: 12,
        name: "インフラ構築・運用",
        client_name: "株式会社クラウドインフラ",
        client_id: 6,
        status: "見積中",
        sales_rep: "伊藤健太",
        amount: 9_000_000,
        start_date: "2025-03-01",
        end_date: "2025-08-31",
        staff_count: 2,
        unit_price: 800_000,
        months: 6,
        probability: 55,
        industry: "IT・通信",
        last_updated: "2025-11-09",
        tags: ["インフラ"],
        description: "Kubernetes環境の構築と運用支援",
        contact_name: "森田太郎",
        contact_email: "morita@cloud-infra.co.jp",
        contact_phone: "03-2233-4455"
      }
    ]
  end

  # スタッフマッチング画面
  def staff_matching
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path },
      { name: @project[:name], path: admin_project_path(@project[:id]) },
      { name: "スタッフマッチング", path: staff_matching_admin_project_path(@project[:id]) }
    ]

    # AIマッチング結果（モックデータ）
    @matched_staff = [
      {
        id: 1,
        name: "山田太郎",
        match_score: 95,
        skills: ["Ruby", "Rails", "React", "AWS"],
        experience_years: 8,
        hourly_rate: 5000,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 24,
        success_rate: 98,
        rating: 4.9,
        location: "東京都",
        certifications: ["AWS認定ソリューションアーキテクト", "Ruby Association Certified Ruby Programmer Gold"],
        recent_projects: ["大手EC サイト開発", "金融システム刷新"],
        availability_percentage: 100,
        reason: "必須スキル(Rails, React)を保有し、類似案件の経験が豊富です。"
      },
      {
        id: 2,
        name: "佐藤次郎",
        match_score: 88,
        skills: ["Ruby", "Rails", "PostgreSQL", "Docker"],
        experience_years: 6,
        hourly_rate: 4500,
        availability: "2週間後〜",
        current_status: "稼働中（11/30終了予定）",
        past_projects: 18,
        success_rate: 95,
        rating: 4.7,
        location: "神奈川県",
        certifications: ["Ruby Association Certified Ruby Programmer Silver"],
        recent_projects: ["SaaSプロダクト開発", "社内システム構築"],
        availability_percentage: 75,
        reason: "バックエンド開発の経験が豊富で、要求スキルとマッチしています。"
      },
      {
        id: 3,
        name: "鈴木花子",
        match_score: 85,
        skills: ["Ruby", "Rails", "Vue.js", "GraphQL"],
        experience_years: 5,
        hourly_rate: 4200,
        availability: "1ヶ月後〜",
        current_status: "稼働中（12/15終了予定）",
        past_projects: 15,
        success_rate: 92,
        rating: 4.6,
        location: "東京都",
        certifications: [],
        recent_projects: ["API開発プロジェクト", "マイクロサービス構築"],
        availability_percentage: 50,
        reason: "フルスタック開発の実績があり、技術スタックが合致しています。"
      },
      {
        id: 4,
        name: "田中健太",
        match_score: 82,
        skills: ["Ruby", "Rails", "MySQL", "Redis"],
        experience_years: 7,
        hourly_rate: 4800,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 20,
        success_rate: 94,
        rating: 4.8,
        location: "千葉県",
        certifications: ["情報処理安全確保支援士"],
        recent_projects: ["決済システム開発", "会員管理システム"],
        availability_percentage: 100,
        reason: "セキュリティを意識した開発経験があり、信頼性の高い実装が期待できます。"
      },
      {
        id: 5,
        name: "伊藤美咲",
        match_score: 78,
        skills: ["Ruby", "Rails", "JavaScript", "TailwindCSS"],
        experience_years: 4,
        hourly_rate: 3800,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 12,
        success_rate: 90,
        rating: 4.5,
        location: "東京都",
        certifications: [],
        recent_projects: ["管理画面開発", "LP制作"],
        availability_percentage: 100,
        reason: "UI/UX実装に強みがあり、フロントエンド開発をサポートできます。"
      }
    ]
  end

  # 募集メール送信（モック）
  def send_recruitment
    staff_ids = params[:staff_ids] || []
    message = params[:message] || ""

    # 実際のメール送信処理はここに実装（モックなのでスキップ）

    flash[:success] = "#{staff_ids.length}名のスタッフに募集メールを送信しました。"
    redirect_to admin_projects_path
  end

  private

  def set_project
    # 実際はDBから取得するが、モックなのでindexのデータを使用
    projects_data = [
      {
        id: 1,
        name: "ECサイトリニューアルプロジェクト",
        client_name: "株式会社サンプルテクノロジー",
        status: "確定",
        amount: 15_000_000,
        start_date: "2025-01-15",
        end_date: "2025-06-30",
        staff_count: 3,
        unit_price: 850_000,
        required_skills: ["Ruby", "Rails", "React", "AWS"],
        description: "既存ECサイトの全面リニューアル。Rails + React構成で実装予定。"
      },
      {
        id: 4,
        name: "データ分析基盤構築",
        client_name: "株式会社ビッグデータソリューションズ",
        status: "確定",
        amount: 20_000_000,
        start_date: "2025-01-10",
        end_date: "2025-12-31",
        staff_count: 2,
        unit_price: 1_000_000,
        required_skills: ["Python", "AWS", "Spark", "SQL"],
        description: "AWS上でのデータレイク・データウェアハウス構築"
      },
      {
        id: 11,
        name: "SaaS開発プロジェクト",
        client_name: "株式会社イノベーション",
        status: "確定",
        amount: 25_000_000,
        start_date: "2025-02-01",
        end_date: "2025-12-31",
        staff_count: 5,
        unit_price: 950_000,
        required_skills: ["Ruby", "Rails", "React", "PostgreSQL", "Docker"],
        description: "BtoB向けSaaSプロダクトの新規開発"
      }
    ]

    @project = projects_data.find { |p| p[:id] == params[:id].to_i }
  end
end
