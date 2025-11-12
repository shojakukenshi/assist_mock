module Admin
  class ClientsController < BaseController
    def index
      add_breadcrumb "クライアント管理"

      # フィルター条件
      @filters = {
        industries: ["イベント企画", "展示会運営", "官公庁", "企業イベント", "ブライダル", "スポーツ団体"],
        regions: ["東京", "大阪", "名古屋", "福岡"],
        statuses: ["稼働中", "要確認", "休止中"]
      }

      # サンプルデータ（イベントスタッフ派遣業務）
      @clients = [
        {
          id: 1,
          name: "日本自動車工業会",
          name_kana: "ニホンジドウシャコウギョウカイ",
          industry: "官公庁",
          status: "稼働中",
          region: "東京",
          address: "東京都港区芝大門1-1-30",
          postal_code: "105-0012",
          contact_name: "田中一郎",
          contact_email: "tanaka@jama.or.jp",
          contact_phone: "03-1234-5678",
          sales_rep: "佐藤花子",
          projects_count: 3,
          active_staff: 85,
          monthly_revenue: 12_500_000,
          total_revenue: 45_000_000,
          contract_start: "2024-01-15",
          contract_end: "2025-12-31",
          last_contact: "2025-11-10",
          created_at: "2024-01-15",
          tags: ["大規模", "VIP対応"]
        },
        {
          id: 2,
          name: "株式会社ミュージックプロモーション",
          name_kana: "カブシキガイシャミュージックプロモーション",
          industry: "イベント企画",
          status: "稼働中",
          region: "東京",
          address: "東京都渋谷区神南1-2-3",
          postal_code: "150-0041",
          contact_name: "山本花子",
          contact_email: "yamamoto@musicpro.co.jp",
          contact_phone: "03-2345-6789",
          sales_rep: "田中次郎",
          projects_count: 5,
          active_staff: 120,
          monthly_revenue: 8_500_000,
          total_revenue: 32_000_000,
          contract_start: "2024-03-01",
          contract_end: "2025-02-28",
          last_contact: "2025-11-11",
          created_at: "2024-03-01",
          tags: ["音楽", "夜間"]
        },
        {
          id: 3,
          name: "グローバルコーポレーション株式会社",
          name_kana: "グローバルコーポレーションカブシキガイシャ",
          industry: "企業イベント",
          status: "稼働中",
          region: "東京",
          address: "東京都千代田区丸の内2-4-1",
          postal_code: "100-0005",
          contact_name: "高橋太郎",
          contact_email: "takahashi@global-corp.co.jp",
          contact_phone: "03-3456-7890",
          sales_rep: "佐藤花子",
          projects_count: 8,
          active_staff: 45,
          monthly_revenue: 6_800_000,
          total_revenue: 28_500_000,
          contract_start: "2023-10-01",
          contract_end: "2025-09-30",
          last_contact: "2025-11-09",
          created_at: "2023-10-01",
          tags: ["企業", "フォーマル"]
        },
        {
          id: 4,
          name: "テクノロジーエキスポ運営委員会",
          name_kana: "テクノロジーエキスポウンエイイインカイ",
          industry: "展示会運営",
          status: "稼働中",
          region: "東京",
          address: "東京都江東区有明3-11-1",
          postal_code: "135-0063",
          contact_name: "渡辺次郎",
          contact_email: "watanabe@techexpo.co.jp",
          contact_phone: "03-4567-8901",
          sales_rep: "伊藤健太",
          projects_count: 12,
          active_staff: 200,
          monthly_revenue: 15_200_000,
          total_revenue: 120_000_000,
          contract_start: "2023-04-01",
          contract_end: "2026-03-31",
          last_contact: "2025-11-12",
          created_at: "2023-04-01",
          tags: ["展示会", "大規模"]
        },
        {
          id: 5,
          name: "東京マラソン実行委員会",
          name_kana: "トウキョウマラソンジッコウイインカイ",
          industry: "スポーツ団体",
          status: "稼働中",
          region: "東京",
          address: "東京都新宿区西新宿2-8-1",
          postal_code: "163-0820",
          contact_name: "中村健太",
          contact_email: "nakamura@tokyomarathon.jp",
          contact_phone: "03-5678-9012",
          sales_rep: "鈴木美咲",
          projects_count: 4,
          active_staff: 150,
          monthly_revenue: 9_500_000,
          total_revenue: 38_000_000,
          contract_start: "2023-11-01",
          contract_end: "2025-10-31",
          last_contact: "2024-10-16",
          created_at: "2023-11-01",
          tags: ["スポーツ", "大規模"]
        },
        {
          id: 6,
          name: "フェスティバルプロダクション株式会社",
          name_kana: "フェスティバルプロダクションカブシキガイシャ",
          industry: "イベント企画",
          status: "稼働中",
          region: "東京",
          address: "東京都港区六本木3-2-1",
          postal_code: "106-0032",
          contact_name: "佐々木翔太",
          contact_email: "sasaki@festpro.co.jp",
          contact_phone: "03-5555-6666",
          sales_rep: "伊藤健太",
          projects_count: 6,
          active_staff: 180,
          monthly_revenue: 11_800_000,
          total_revenue: 52_000_000,
          contract_start: "2024-02-01",
          contract_end: "2026-01-31",
          last_contact: "2025-11-11",
          created_at: "2024-02-01",
          tags: ["音楽", "屋外"]
        },
        {
          id: 7,
          name: "国際交流協会",
          name_kana: "コクサイコウリュウキョウカイ",
          industry: "官公庁",
          status: "稼働中",
          region: "東京",
          address: "東京都千代田区霞が関1-1-1",
          postal_code: "100-0013",
          contact_name: "林美咲",
          contact_email: "hayashi@intl-exchange.go.jp",
          contact_phone: "03-6789-0123",
          sales_rep: "佐藤花子",
          projects_count: 5,
          active_staff: 95,
          monthly_revenue: 8_200_000,
          total_revenue: 36_500_000,
          contract_start: "2023-04-01",
          contract_end: "2026-03-31",
          last_contact: "2024-09-20",
          created_at: "2023-04-01",
          tags: ["国際", "VIP"]
        },
        {
          id: 8,
          name: "ウェディングプランナーズ",
          name_kana: "ウェディングプランナーズ",
          industry: "ブライダル",
          status: "稼働中",
          region: "東京",
          address: "東京都港区赤坂9-7-1",
          postal_code: "107-0052",
          contact_name: "吉田美穂",
          contact_email: "yoshida@wedding-planners.co.jp",
          contact_phone: "03-7890-1234",
          sales_rep: "鈴木美咲",
          projects_count: 15,
          active_staff: 65,
          monthly_revenue: 5_400_000,
          total_revenue: 24_300_000,
          contract_start: "2024-01-10",
          contract_end: "2025-01-09",
          last_contact: "2025-11-10",
          created_at: "2024-01-10",
          tags: ["ブライダル", "フォーマル"]
        },
        {
          id: 9,
          name: "株式会社トレードフェア",
          name_kana: "カブシキガイシャトレードフェア",
          industry: "展示会運営",
          status: "要確認",
          region: "横浜",
          address: "神奈川県横浜市西区みなとみらい1-1-1",
          postal_code: "220-0012",
          contact_name: "加藤雄介",
          contact_email: "kato@tradefair.co.jp",
          contact_phone: "045-1234-5678",
          sales_rep: "田中次郎",
          projects_count: 2,
          active_staff: 35,
          monthly_revenue: 2_800_000,
          total_revenue: 14_500_000,
          contract_start: "2024-06-01",
          contract_end: "2025-05-31",
          last_contact: "2025-10-15",
          created_at: "2024-06-01",
          tags: ["展示会", "要フォロー"]
        },
        {
          id: 10,
          name: "ビジネスソリューションズ株式会社",
          name_kana: "ビジネスソリューションズカブシキガイシャ",
          industry: "企業イベント",
          status: "稼働中",
          region: "東京",
          address: "東京都品川区東品川2-2-20",
          postal_code: "140-0002",
          contact_name: "森田誠",
          contact_email: "morita@biz-sol.co.jp",
          contact_phone: "03-8901-2345",
          sales_rep: "伊藤健太",
          projects_count: 7,
          active_staff: 55,
          monthly_revenue: 4_900_000,
          total_revenue: 29_400_000,
          contract_start: "2023-08-01",
          contract_end: "2025-07-31",
          last_contact: "2025-11-10",
          created_at: "2023-08-01",
          tags: ["企業", "セミナー"]
        }
      ]

      # 統計サマリー
      @summary = {
        total_clients: @clients.count,
        active_clients: @clients.count { |c| c[:status] == "稼働中" },
        total_projects: @clients.sum { |c| c[:projects_count] },
        monthly_revenue: @clients.sum { |c| c[:monthly_revenue] }
      }
    end

    def show
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "クライアント詳細"
    end

    def new
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "新規登録"
    end

    def edit
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "編集"
    end
  end
end
