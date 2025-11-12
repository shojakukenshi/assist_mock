class Admin::Sales::PipelineController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "営業管理", path: admin_sales_pipeline_path },
      { name: "案件進捗管理", path: admin_sales_pipeline_path }
    ]

    # ステージ定義
    @stages = [
      { id: "negotiation", name: "商談中", color: "orange", count: 8 },
      { id: "estimate", name: "見積中", color: "yellow", count: 5 },
      { id: "ordered", name: "受注", color: "green", count: 6 },
      { id: "delivery", name: "納品", color: "blue", count: 3 },
      { id: "billed", name: "請求完了", color: "purple", count: 2 }
    ]

    # KPIサマリー
    @summary = {
      total_deals: 24,
      total_value: 145_800_000,
      expected_revenue: 95_200_000,
      success_rate: 75.0,
      average_lead_time: 45 # 日数
    }

    # カンバンデータ
    @deals = {
      negotiation: [
        {
          id: 1,
          name: "クラウド移行支援",
          client: "株式会社レガシーシステムズ",
          amount: 18_000_000,
          probability: 60,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-11",
          tags: ["大型案件", "クラウド"],
          priority: "high"
        },
        {
          id: 2,
          name: "モバイルアプリ開発",
          client: "株式会社グローバルサービス",
          amount: 12_000_000,
          probability: 50,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-09",
          tags: ["高単価"],
          priority: "medium"
        },
        {
          id: 3,
          name: "Webサイト制作",
          client: "株式会社スタートアップ",
          amount: 2_800_000,
          probability: 40,
          sales_rep: "田中次郎",
          last_updated: "2025-11-07",
          tags: ["小規模"],
          priority: "low"
        }
      ],
      estimate: [
        {
          id: 4,
          name: "社内業務システム開発",
          client: "株式会社メガコーポレーション",
          amount: 8_500_000,
          probability: 70,
          sales_rep: "田中次郎",
          last_updated: "2025-11-11",
          tags: ["新規"],
          priority: "high"
        },
        {
          id: 5,
          name: "AIチャットボット導入",
          client: "株式会社カスタマーサポート",
          amount: 7_500_000,
          probability: 65,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-10",
          tags: ["AI", "新技術"],
          priority: "high"
        },
        {
          id: 6,
          name: "インフラ構築・運用",
          client: "株式会社クラウドインフラ",
          amount: 9_000_000,
          probability: 55,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-09",
          tags: ["インフラ"],
          priority: "medium"
        }
      ],
      ordered: [
        {
          id: 7,
          name: "ECサイトリニューアル",
          client: "株式会社サンプルテクノロジー",
          amount: 15_000_000,
          probability: 95,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-10",
          tags: ["重要", "大型案件"],
          priority: "high"
        },
        {
          id: 8,
          name: "データ分析基盤構築",
          client: "株式会社ビッグデータソリューションズ",
          amount: 20_000_000,
          probability: 100,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-12",
          tags: ["長期", "大型案件"],
          priority: "high"
        },
        {
          id: 9,
          name: "SaaS開発プロジェクト",
          client: "株式会社イノベーション",
          amount: 25_000_000,
          probability: 100,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-12",
          tags: ["重要", "大型案件"],
          priority: "high"
        }
      ],
      delivery: [
        {
          id: 10,
          name: "基幹システム保守",
          client: "株式会社エンタープライズ",
          amount: 6_000_000,
          probability: 100,
          sales_rep: "田中次郎",
          last_updated: "2025-11-08",
          tags: ["保守"],
          priority: "medium"
        },
        {
          id: 11,
          name: "セキュリティ診断",
          client: "株式会社セキュアシステムズ",
          amount: 3_500_000,
          probability: 100,
          sales_rep: "鈴木美咲",
          last_updated: "2025-11-05",
          tags: ["セキュリティ"],
          priority: "medium"
        }
      ],
      billed: [
        {
          id: 12,
          name: "業務効率化コンサル",
          client: "株式会社効率化ソリューション",
          amount: 4_500_000,
          probability: 100,
          sales_rep: "鈴木美咲",
          last_updated: "2025-11-01",
          tags: ["完了"],
          priority: "low"
        }
      ]
    }
  end
end
