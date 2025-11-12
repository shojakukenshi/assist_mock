module Admin
  class ClientsController < BaseController
    def index
      add_breadcrumb "クライアント管理"

      # フィルター条件
      @filters = {
        industries: ["IT・通信", "商社", "製造業", "金融", "サービス業"],
        regions: ["東京", "大阪", "名古屋", "福岡"],
        statuses: ["稼働中", "要確認", "休止中"]
      }

      # サンプルデータ（拡張版）
      @clients = [
        {
          id: 1,
          name: "株式会社サンプルテクノロジー",
          name_kana: "カブシキガイシャサンプルテクノロジー",
          industry: "IT・通信",
          status: "稼働中",
          region: "東京",
          address: "東京都渋谷区渋谷1-1-1",
          postal_code: "150-0001",
          contact_name: "山田太郎",
          contact_email: "yamada@sample-tech.co.jp",
          contact_phone: "03-1234-5678",
          sales_rep: "佐藤花子",
          projects_count: 5,
          active_staff: 12,
          monthly_revenue: 4_500_000,
          total_revenue: 24_000_000,
          contract_start: "2024-01-15",
          contract_end: "2025-01-14",
          last_contact: "2024-11-08",
          created_at: "2024-01-15",
          tags: ["優良", "IT"]
        },
        {
          id: 2,
          name: "○○商事株式会社",
          name_kana: "マルマルショウジカブシキガイシャ",
          industry: "商社",
          status: "稼働中",
          region: "大阪",
          address: "大阪府大阪市北区梅田2-2-2",
          postal_code: "530-0001",
          contact_name: "鈴木一郎",
          contact_email: "suzuki@marumaru-shoji.co.jp",
          contact_phone: "06-1234-5678",
          sales_rep: "田中次郎",
          projects_count: 3,
          active_staff: 8,
          monthly_revenue: 2_800_000,
          total_revenue: 16_800_000,
          contract_start: "2024-02-20",
          contract_end: "2025-02-19",
          last_contact: "2024-11-05",
          created_at: "2024-02-20",
          tags: ["商社", "大阪"]
        },
        {
          id: 3,
          name: "△△製造株式会社",
          name_kana: "サンカクサンカクセイゾウカブシキガイシャ",
          industry: "製造業",
          status: "要確認",
          region: "名古屋",
          address: "愛知県名古屋市中区栄3-3-3",
          postal_code: "460-0008",
          contact_name: "高橋美咲",
          contact_email: "takahashi@sankaku-mfg.co.jp",
          contact_phone: "052-1234-5678",
          sales_rep: "伊藤健太",
          projects_count: 1,
          active_staff: 3,
          monthly_revenue: 900_000,
          total_revenue: 10_800_000,
          contract_start: "2023-12-10",
          contract_end: "2024-12-09",
          last_contact: "2024-10-15",
          created_at: "2023-12-10",
          tags: ["製造", "要フォロー"]
        },
        {
          id: 4,
          name: "□□フィナンシャルグループ",
          name_kana: "シカクシカクフィナンシャルグループ",
          industry: "金融",
          status: "稼働中",
          region: "東京",
          address: "東京都千代田区丸の内4-4-4",
          postal_code: "100-0005",
          contact_name: "中村麗奈",
          contact_email: "nakamura@shikaku-fg.co.jp",
          contact_phone: "03-9876-5432",
          sales_rep: "佐藤花子",
          projects_count: 8,
          active_staff: 20,
          monthly_revenue: 8_200_000,
          total_revenue: 98_400_000,
          contract_start: "2023-11-05",
          contract_end: "2024-11-04",
          last_contact: "2024-11-10",
          created_at: "2023-11-05",
          tags: ["優良", "大口", "金融"]
        },
        {
          id: 5,
          name: "◇◇サービス株式会社",
          name_kana: "ヒシヒシサービスカブシキガイシャ",
          industry: "サービス業",
          status: "休止中",
          region: "福岡",
          address: "福岡県福岡市博多区博多駅前5-5-5",
          postal_code: "812-0011",
          contact_name: "小林誠",
          contact_email: "kobayashi@hishi-service.co.jp",
          contact_phone: "092-1234-5678",
          sales_rep: "田中次郎",
          projects_count: 0,
          active_staff: 0,
          monthly_revenue: 0,
          total_revenue: 5_400_000,
          contract_start: "2023-06-01",
          contract_end: "2024-05-31",
          last_contact: "2024-05-20",
          created_at: "2023-06-01",
          tags: ["休止"]
        },
        {
          id: 6,
          name: "★★コンサルティング株式会社",
          name_kana: "ホシホシコンサルティングカブシキガイシャ",
          industry: "サービス業",
          status: "稼働中",
          region: "東京",
          address: "東京都港区六本木6-6-6",
          postal_code: "106-0032",
          contact_name: "渡辺直美",
          contact_email: "watanabe@hoshi-consulting.co.jp",
          contact_phone: "03-5555-6666",
          sales_rep: "伊藤健太",
          projects_count: 4,
          active_staff: 10,
          monthly_revenue: 3_600_000,
          total_revenue: 21_600_000,
          contract_start: "2024-03-01",
          contract_end: "2025-02-28",
          last_contact: "2024-11-09",
          created_at: "2024-03-01",
          tags: ["コンサル", "成長中"]
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
