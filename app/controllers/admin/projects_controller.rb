class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:staff_matching, :send_recruitment]

  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path }
    ]

    # ステータス定義
    @statuses = ["商談中", "見積中", "確定", "完了", "失注"]

    # フィルタオプション
    @filters = {
      statuses: @statuses,
      sales_reps: ["佐藤花子", "田中次郎", "伊藤健太", "鈴木美咲"],
      industries: ["イベント企画", "展示会運営", "官公庁", "企業イベント", "ブライダル", "スポーツ団体"]
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

    # サンプル案件データ（イベントスタッフ派遣業務）
    @projects = [
      {
        id: 1,
        name: "東京モーターショー2025",
        client_name: "日本自動車工業会",
        client_id: 1,
        status: "確定",
        sales_rep: "佐藤花子",
        amount: 8_500_000,
        start_date: "2025-11-20",
        end_date: "2025-11-24",
        staff_count: 50,
        unit_price: 3_400,
        months: 1,
        probability: 100,
        industry: "官公庁",
        last_updated: "2025-11-10",
        tags: ["大規模", "VIP対応"],
        description: "東京ビッグサイトで開催される自動車展示会。受付、誘導、通訳スタッフを派遣。",
        contact_name: "田中一郎",
        contact_email: "tanaka@jama.or.jp",
        contact_phone: "03-1234-5678",
        venue: "東京ビッグサイト",
        work_hours: "09:00-18:00",
        required_skills: ["接客", "英語", "イベント経験"]
      },
      {
        id: 2,
        name: "年末チャリティーコンサート",
        client_name: "株式会社ミュージックプロモーション",
        client_id: 2,
        status: "見積中",
        sales_rep: "田中次郎",
        amount: 2_800_000,
        start_date: "2025-12-20",
        end_date: "2025-12-20",
        staff_count: 30,
        unit_price: 3_000,
        months: 1,
        probability: 70,
        industry: "イベント企画",
        last_updated: "2025-11-11",
        tags: ["夜間", "音楽"],
        description: "東京国際フォーラムでのチャリティーコンサート。会場設営、受付、誘導スタッフを派遣。",
        contact_name: "山本花子",
        contact_email: "yamamoto@musicpro.co.jp",
        contact_phone: "03-2345-6789",
        venue: "東京国際フォーラム",
        work_hours: "14:00-22:00",
        required_skills: ["イベント経験", "接客", "夜間対応"]
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
        staff_count: 15,
        unit_price: 4_000,
        months: 1,
        probability: 60,
        industry: "企業イベント",
        last_updated: "2025-11-09",
        tags: ["フォーマル", "高単価"],
        description: "創立50周年記念パーティー。受付、クローク、配膳サポートスタッフを派遣。",
        contact_name: "高橋太郎",
        contact_email: "takahashi@global-corp.co.jp",
        contact_phone: "03-3456-7890",
        venue: "帝国ホテル",
        work_hours: "17:00-22:00",
        required_skills: ["フォーマル対応", "接客", "配膳経験"]
      },
      {
        id: 4,
        name: "企業展示会サポート",
        client_name: "テクノロジーエキスポ運営委員会",
        client_id: 4,
        status: "確定",
        sales_rep: "伊藤健太",
        amount: 6_500_000,
        start_date: "2025-11-13",
        end_date: "2025-11-15",
        staff_count: 40,
        unit_price: 3_200,
        months: 1,
        probability: 100,
        industry: "展示会運営",
        last_updated: "2025-11-12",
        tags: ["進行中", "IT業界"],
        description: "幕張メッセでの技術展示会。受付、誘導、出展サポートスタッフを派遣。",
        contact_name: "渡辺次郎",
        contact_email: "watanabe@techexpo.co.jp",
        contact_phone: "03-4567-8901",
        venue: "幕張メッセ",
        work_hours: "09:00-17:00",
        required_skills: ["展示会経験", "接客", "IT知識"]
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
        staff_count: 80,
        unit_price: 3_000,
        months: 1,
        probability: 100,
        industry: "スポーツ団体",
        last_updated: "2024-10-16",
        tags: ["大規模", "屋外"],
        description: "都内各所でのマラソン大会。給水所、誘導、ゴール地点運営スタッフを派遣。",
        contact_name: "中村健太",
        contact_email: "nakamura@tokyomarathon.jp",
        contact_phone: "03-5678-9012",
        venue: "都内各所",
        work_hours: "06:00-14:00",
        required_skills: ["体力", "早朝対応", "屋外イベント経験"]
      },
      {
        id: 6,
        name: "音楽フェスティバル運営",
        client_name: "フェスティバルプロダクション株式会社",
        client_id: 6,
        status: "確定",
        sales_rep: "伊藤健太",
        amount: 5_500_000,
        start_date: "2025-12-28",
        end_date: "2025-12-29",
        staff_count: 60,
        unit_price: 3_500,
        months: 1,
        probability: 100,
        industry: "イベント企画",
        last_updated: "2025-11-11",
        tags: ["屋外", "大規模"],
        description: "お台場特設会場での音楽フェス。受付、誘導、物販サポートスタッフを派遣。",
        contact_name: "佐々木翔太",
        contact_email: "sasaki@festpro.co.jp",
        contact_phone: "03-5555-6666",
        venue: "お台場特設会場",
        work_hours: "10:00-21:00",
        required_skills: ["イベント経験", "接客", "屋外対応"]
      },
      {
        id: 7,
        name: "国際会議サポート",
        client_name: "国際交流協会",
        client_id: 7,
        status: "完了",
        sales_rep: "佐藤花子",
        amount: 3_200_000,
        start_date: "2024-09-15",
        end_date: "2024-09-17",
        staff_count: 35,
        unit_price: 4_500,
        months: 1,
        probability: 100,
        industry: "官公庁",
        last_updated: "2024-09-20",
        tags: ["VIP", "国際"],
        description: "東京プリンスホテルでの国際会議。受付、通訳サポート、誘導スタッフを派遣。",
        contact_name: "林美咲",
        contact_email: "hayashi@intl-exchange.go.jp",
        contact_phone: "03-6789-0123",
        venue: "東京プリンスホテル",
        work_hours: "08:00-19:00",
        required_skills: ["英語", "VIP対応", "フォーマル対応"]
      },
      {
        id: 8,
        name: "結婚式サポート",
        client_name: "ウェディングプランナーズ",
        client_id: 8,
        status: "見積中",
        sales_rep: "鈴木美咲",
        amount: 800_000,
        start_date: "2026-03-15",
        end_date: "2026-03-15",
        staff_count: 10,
        unit_price: 4_000,
        months: 1,
        probability: 70,
        industry: "ブライダル",
        last_updated: "2025-11-10",
        tags: ["ブライダル", "フォーマル"],
        description: "ホテルニューオータニでの結婚式。受付、クローク、配膳サポートスタッフを派遣。",
        contact_name: "吉田美穂",
        contact_email: "yoshida@wedding-planners.co.jp",
        contact_phone: "03-7890-1234",
        venue: "ホテルニューオータニ",
        work_hours: "10:00-22:00",
        required_skills: ["フォーマル対応", "配膳経験", "ブライダル経験"]
      },
      {
        id: 9,
        name: "商品展示会サポート",
        client_name: "株式会社トレードフェア",
        client_id: 9,
        status: "失注",
        sales_rep: "田中次郎",
        amount: 2_500_000,
        start_date: nil,
        end_date: nil,
        staff_count: 20,
        unit_price: 3_000,
        months: 1,
        probability: 0,
        industry: "展示会運営",
        last_updated: "2025-10-20",
        tags: ["失注理由: 予算"],
        description: "パシフィコ横浜での商品展示会。受付、誘導スタッフを派遣予定だったが予算不足で失注。",
        contact_name: "加藤雄介",
        contact_email: "kato@tradefair.co.jp",
        contact_phone: "045-1234-5678",
        venue: "パシフィコ横浜",
        work_hours: "09:00-18:00",
        required_skills: ["展示会経験", "接客"]
      },
      {
        id: 10,
        name: "企業セミナー運営",
        client_name: "ビジネスソリューションズ株式会社",
        client_id: 10,
        status: "商談中",
        sales_rep: "伊藤健太",
        amount: 1_500_000,
        start_date: "2025-12-05",
        end_date: "2025-12-05",
        staff_count: 20,
        unit_price: 3_500,
        months: 1,
        probability: 65,
        industry: "企業イベント",
        last_updated: "2025-11-10",
        tags: ["セミナー"],
        description: "品川グランドホールでの企業セミナー。受付、誘導、配布資料準備スタッフを派遣。",
        contact_name: "森田誠",
        contact_email: "morita@biz-sol.co.jp",
        contact_phone: "03-8901-2345",
        venue: "品川グランドホール",
        work_hours: "08:00-18:00",
        required_skills: ["接客", "セミナー経験", "ビジネスマナー"]
      },
      {
        id: 11,
        name: "新製品発表会",
        client_name: "グローバルコーポレーション株式会社",
        client_id: 3,
        status: "確定",
        sales_rep: "佐藤花子",
        amount: 2_400_000,
        start_date: "2025-12-10",
        end_date: "2025-12-10",
        staff_count: 25,
        unit_price: 3_800,
        months: 1,
        probability: 100,
        industry: "企業イベント",
        last_updated: "2025-11-12",
        tags: ["新規", "プレスイベント"],
        description: "丸の内本社ビルでの新製品発表会。受付、誘導、報道対応サポートスタッフを派遣。",
        contact_name: "高橋太郎",
        contact_email: "takahashi@global-corp.co.jp",
        contact_phone: "03-3456-7890",
        venue: "丸の内本社ビル",
        work_hours: "13:00-19:00",
        required_skills: ["接客", "プレス対応", "フォーマル対応"]
      },
      {
        id: 12,
        name: "春のブライダルフェア",
        client_name: "ウェディングプランナーズ",
        client_id: 8,
        status: "見積中",
        sales_rep: "鈴木美咲",
        amount: 1_800_000,
        start_date: "2026-03-28",
        end_date: "2026-03-29",
        staff_count: 20,
        unit_price: 3_500,
        months: 1,
        probability: 55,
        industry: "ブライダル",
        last_updated: "2025-11-09",
        tags: ["ブライダル", "週末"],
        description: "ホテルニューオータニでのブライダルフェア。受付、会場案内、模擬挙式サポートスタッフを派遣。",
        contact_name: "吉田美穂",
        contact_email: "yoshida@wedding-planners.co.jp",
        contact_phone: "03-7890-1234",
        venue: "ホテルニューオータニ",
        work_hours: "09:00-18:00",
        required_skills: ["ブライダル経験", "接客", "フォーマル対応"]
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
        skills: ["接客", "英語", "イベント経験", "VIP対応"],
        experience_years: 8,
        hourly_rate: 3_500,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 24,
        success_rate: 98,
        rating: 4.9,
        location: "東京都",
        certifications: ["TOEIC 900点", "イベント検定"],
        recent_projects: ["東京モーターショー2024", "国際会議サポート"],
        availability_percentage: 100,
        reason: "必須スキル(接客、英語)を保有し、大規模展示会の経験が豊富です。"
      },
      {
        id: 2,
        name: "佐藤次郎",
        match_score: 88,
        skills: ["接客", "イベント経験", "展示会経験", "誘導"],
        experience_years: 6,
        hourly_rate: 3_200,
        availability: "2週間後〜",
        current_status: "稼働中（11/30終了予定）",
        past_projects: 18,
        success_rate: 95,
        rating: 4.7,
        location: "神奈川県",
        certifications: ["イベント業務管理者1級"],
        recent_projects: ["テクノロジーエキスポ2024", "企業セミナー運営"],
        availability_percentage: 75,
        reason: "展示会運営の経験が豊富で、要求スキルとマッチしています。"
      },
      {
        id: 3,
        name: "鈴木花子",
        match_score: 85,
        skills: ["接客", "フォーマル対応", "配膳経験", "ブライダル経験"],
        experience_years: 5,
        hourly_rate: 3_000,
        availability: "1ヶ月後〜",
        current_status: "稼働中（12/15終了予定）",
        past_projects: 15,
        success_rate: 92,
        rating: 4.6,
        location: "東京都",
        certifications: [],
        recent_projects: ["結婚式サポート", "企業パーティー運営"],
        availability_percentage: 50,
        reason: "フォーマルイベントの実績があり、接客スキルが高いです。"
      },
      {
        id: 4,
        name: "田中健太",
        match_score: 82,
        skills: ["接客", "英語", "中国語", "通訳サポート"],
        experience_years: 7,
        hourly_rate: 4_000,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 20,
        success_rate: 94,
        rating: 4.8,
        location: "千葉県",
        certifications: ["TOEIC 950点", "中国語検定2級"],
        recent_projects: ["国際会議サポート", "外国人向けツアーガイド"],
        availability_percentage: 100,
        reason: "多言語対応が可能で、国際的なイベントに最適です。"
      },
      {
        id: 5,
        name: "伊藤美咲",
        match_score: 78,
        skills: ["接客", "受付", "事務サポート", "PC操作"],
        experience_years: 4,
        hourly_rate: 2_800,
        availability: "即日可能",
        current_status: "待機中",
        past_projects: 12,
        success_rate: 90,
        rating: 4.5,
        location: "東京都",
        certifications: [],
        recent_projects: ["展示会受付", "セミナー運営サポート"],
        availability_percentage: 100,
        reason: "受付業務に強みがあり、スムーズな来場者対応が期待できます。"
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
        name: "東京モーターショー2025",
        client_name: "日本自動車工業会",
        status: "確定",
        amount: 8_500_000,
        start_date: "2025-11-20",
        end_date: "2025-11-24",
        staff_count: 50,
        unit_price: 3_400,
        required_skills: ["接客", "英語", "イベント経験", "VIP対応"],
        description: "東京ビッグサイトで開催される自動車展示会。受付、誘導、通訳スタッフを派遣。"
      },
      {
        id: 4,
        name: "企業展示会サポート",
        client_name: "テクノロジーエキスポ運営委員会",
        status: "確定",
        amount: 6_500_000,
        start_date: "2025-11-13",
        end_date: "2025-11-15",
        staff_count: 40,
        unit_price: 3_200,
        required_skills: ["展示会経験", "接客", "IT知識", "誘導"],
        description: "幕張メッセでの技術展示会。受付、誘導、出展サポートスタッフを派遣。"
      },
      {
        id: 11,
        name: "新製品発表会",
        client_name: "グローバルコーポレーション株式会社",
        status: "確定",
        amount: 2_400_000,
        start_date: "2025-12-10",
        end_date: "2025-12-10",
        staff_count: 25,
        unit_price: 3_800,
        required_skills: ["接客", "プレス対応", "フォーマル対応", "ビジネスマナー"],
        description: "丸の内本社ビルでの新製品発表会。受付、誘導、報道対応サポートスタッフを派遣。"
      }
    ]

    @project = projects_data.find { |p| p[:id] == params[:id].to_i }
  end
end
