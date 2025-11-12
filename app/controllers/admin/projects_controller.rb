class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:staff_matching, :send_recruitment]

  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path }
    ]

    # ステータス定義
    @statuses = ["商談中", "見積中", "確定", "完了", "失注"]

    # 応募通知（モックデータ）
    @pending_applications = [
      { id: 1, project_id: 1, project_name: "ECサイトリニューアルプロジェクト", staff_name: "山田太郎", staff_id: 1, applied_at: "2025-11-10 10:30", status: "pending" },
      { id: 2, project_id: 4, project_name: "データ分析基盤構築", staff_name: "佐藤次郎", staff_id: 2, applied_at: "2025-11-11 14:20", status: "pending" },
      { id: 3, project_id: 11, project_name: "SaaS開発プロジェクト", staff_name: "鈴木花子", staff_id: 3, applied_at: "2025-11-12 09:15", status: "pending" }
    ]

    # フィルタオプション
    @filters = {
      statuses: @statuses,
      sales_reps: ["佐藤花子", "田中次郎", "伊藤健太", "鈴木美咲"],
      industries: ["IT・通信", "製造業", "金融", "小売", "サービス", "医療・福祉", "建設", "その他"]
    }

    # KPI集計
    @summary = {
      total_projects: 24,
      negotiating: 8,
      estimating: 5,
      confirmed: 6,
      completed: 3,
      lost: 2,
      total_value: 145_800_000,
      monthly_revenue: 12_150_000,
      success_rate: 75.0
    }

    # サンプル案件データ
    @projects = [
      {
        id: 1,
        name: "ECサイトリニューアルプロジェクト",
        client_name: "株式会社サンプルテクノロジー",
        client_id: 1,
        status: "確定",
        sales_rep: "佐藤花子",
        amount: 15_000_000,
        start_date: "2025-01-15",
        end_date: "2025-06-30",
        staff_count: 3,
        unit_price: 850_000,
        months: 6,
        probability: 95,
        industry: "IT・通信",
        last_updated: "2025-11-10",
        tags: ["重要", "大型案件"],
        description: "既存ECサイトの全面リニューアル。Rails + React構成で実装予定。",
        contact_name: "山田太郎",
        contact_email: "yamada@sample-tech.co.jp",
        contact_phone: "03-1234-5678"
      },
      {
        id: 2,
        name: "社内業務システム開発",
        client_name: "株式会社メガコーポレーション",
        client_id: 2,
        status: "見積中",
        sales_rep: "田中次郎",
        amount: 8_500_000,
        start_date: "2025-02-01",
        end_date: "2025-04-30",
        staff_count: 2,
        unit_price: 800_000,
        months: 5,
        probability: 70,
        industry: "製造業",
        last_updated: "2025-11-11",
        tags: ["新規"],
        description: "在庫管理・受発注システムの新規開発",
        contact_name: "鈴木一郎",
        contact_email: "suzuki@mega-corp.co.jp",
        contact_phone: "03-2345-6789"
      },
      {
        id: 3,
        name: "モバイルアプリ開発（iOS/Android）",
        client_name: "株式会社グローバルサービス",
        client_id: 3,
        status: "商談中",
        sales_rep: "佐藤花子",
        amount: 12_000_000,
        start_date: "2025-03-01",
        end_date: "2025-08-31",
        staff_count: 4,
        unit_price: 900_000,
        months: 6,
        probability: 50,
        industry: "IT・通信",
        last_updated: "2025-11-09",
        tags: ["高単価"],
        description: "顧客向けサービスアプリのネイティブ開発",
        contact_name: "高橋花子",
        contact_email: "takahashi@global-service.co.jp",
        contact_phone: "03-3456-7890"
      },
      {
        id: 4,
        name: "データ分析基盤構築",
        client_name: "株式会社ビッグデータソリューションズ",
        client_id: 4,
        status: "確定",
        sales_rep: "伊藤健太",
        amount: 20_000_000,
        start_date: "2025-01-10",
        end_date: "2025-12-31",
        staff_count: 2,
        unit_price: 1_000_000,
        months: 12,
        probability: 100,
        industry: "IT・通信",
        last_updated: "2025-11-12",
        tags: ["長期", "大型案件"],
        description: "AWS上でのデータレイク・データウェアハウス構築",
        contact_name: "渡辺次郎",
        contact_email: "watanabe@bigdata-sol.co.jp",
        contact_phone: "03-4567-8901"
      },
      {
        id: 5,
        name: "セキュリティ診断・改善",
        client_name: "株式会社セキュアシステムズ",
        client_id: 5,
        status: "完了",
        sales_rep: "鈴木美咲",
        amount: 3_500_000,
        start_date: "2024-10-01",
        end_date: "2024-12-31",
        staff_count: 1,
        unit_price: 750_000,
        months: 3,
        probability: 100,
        industry: "IT・通信",
        last_updated: "2025-01-05",
        tags: ["セキュリティ"],
        description: "Webアプリケーションのセキュリティ診断と脆弱性対策",
        contact_name: "中村美咲",
        contact_email: "nakamura@secure-sys.co.jp",
        contact_phone: "03-5678-9012"
      },
      {
        id: 6,
        name: "基幹システム保守",
        client_name: "株式会社エンタープライズ",
        client_id: 6,
        status: "確定",
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
