class Admin::Sales::PipelineController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "営業管理", path: admin_sales_pipeline_path },
      { name: "案件進捗管理", path: admin_sales_pipeline_path }
    ]

    # ステージ定義
    @stages = [
      { id: "negotiation", name: "商談中", color: "orange", count: 3 },
      { id: "estimate", name: "見積提出", color: "yellow", count: 2 },
      { id: "arranging", name: "確定/手配中", color: "purple", count: 2 },
      { id: "in_progress", name: "進行中", color: "green", count: 1 },
      { id: "completed", name: "完了", color: "blue", count: 2 }
    ]

    # KPIサマリー
    @summary = {
      total_deals: 10,
      total_value: 31_800_000,
      expected_revenue: 24_300_000,
      success_rate: 85.0,
      average_lead_time: 18 # 日数
    }

    # カンバンデータ（イベントスタッフ派遣案件）
    @deals = {
      negotiation: [
        {
          id: 1,
          name: "企業周年記念パーティー",
          client: "グローバルコーポレーション株式会社",
          amount: 1_200_000,
          probability: 60,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-09",
          tags: ["フォーマル", "高単価"],
          priority: "medium",
          venue: "帝国ホテル",
          event_date: "2026-01-25",
          staff_count: 15,
          work_hours: "17:00-22:00"
        },
        {
          id: 2,
          name: "商品展示会サポート",
          client: "株式会社トレードフェア",
          amount: 3_500_000,
          probability: 50,
          sales_rep: "田中次郎",
          last_updated: "2025-11-08",
          tags: ["展示会"],
          priority: "medium",
          venue: "パシフィコ横浜",
          event_date: "2026-02-10～02-12",
          staff_count: 25,
          work_hours: "09:00-18:00"
        },
        {
          id: 3,
          name: "結婚式サポート",
          client: "ウェディングプランナーズ",
          amount: 800_000,
          probability: 70,
          sales_rep: "鈴木美咲",
          last_updated: "2025-11-10",
          tags: ["ブライダル"],
          priority: "low",
          venue: "ホテルニューオータニ",
          event_date: "2026-03-15",
          staff_count: 10,
          work_hours: "10:00-22:00"
        }
      ],
      estimate: [
        {
          id: 4,
          name: "年末チャリティーコンサート",
          client: "株式会社ミュージックプロモーション",
          amount: 2_800_000,
          probability: 70,
          sales_rep: "田中次郎",
          last_updated: "2025-11-11",
          tags: ["夜間", "音楽"],
          priority: "high",
          venue: "東京国際フォーラム",
          event_date: "2025-12-20",
          staff_count: 30,
          work_hours: "14:00-22:00"
        },
        {
          id: 5,
          name: "企業セミナー運営",
          client: "ビジネスソリューションズ株式会社",
          amount: 1_500_000,
          probability: 65,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-10",
          tags: ["セミナー"],
          priority: "medium",
          venue: "品川グランドホール",
          event_date: "2025-12-05",
          staff_count: 20,
          work_hours: "08:00-18:00"
        }
      ],
      arranging: [
        {
          id: 6,
          name: "東京モーターショー2025",
          client: "日本自動車工業会",
          amount: 8_500_000,
          probability: 100,
          sales_rep: "佐藤花子",
          last_updated: "2025-11-10",
          tags: ["大規模", "VIP対応"],
          priority: "high",
          venue: "東京ビッグサイト",
          event_date: "2025-11-20～11-24",
          staff_count: 50,
          work_hours: "09:00-18:00"
        },
        {
          id: 7,
          name: "音楽フェスティバル運営",
          client: "フェスティバルプロダクション株式会社",
          amount: 5_500_000,
          probability: 100,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-11",
          tags: ["屋外", "大規模"],
          priority: "high",
          venue: "お台場特設会場",
          event_date: "2025-12-28～12-29",
          staff_count: 60,
          work_hours: "10:00-21:00"
        }
      ],
      in_progress: [
        {
          id: 8,
          name: "企業展示会サポート",
          client: "テクノロジーエキスポ運営委員会",
          amount: 6_500_000,
          probability: 100,
          sales_rep: "伊藤健太",
          last_updated: "2025-11-12",
          tags: ["進行中", "IT業界"],
          priority: "high",
          venue: "幕張メッセ",
          event_date: "2025-11-13～11-15",
          staff_count: 40,
          work_hours: "09:00-17:00"
        }
      ],
      completed: [
        {
          id: 9,
          name: "マラソン大会運営サポート",
          client: "東京マラソン実行委員会",
          amount: 4_800_000,
          probability: 100,
          sales_rep: "鈴木美咲",
          last_updated: "2024-10-16",
          tags: ["大規模", "屋外"],
          priority: "low",
          venue: "都内各所",
          event_date: "2024-10-15",
          staff_count: 80,
          work_hours: "06:00-14:00"
        },
        {
          id: 10,
          name: "国際会議サポート",
          client: "国際交流協会",
          amount: 3_200_000,
          probability: 100,
          sales_rep: "佐藤花子",
          last_updated: "2024-09-20",
          tags: ["完了", "VIP"],
          priority: "low",
          venue: "東京プリンスホテル",
          event_date: "2024-09-15～09-17",
          staff_count: 35,
          work_hours: "08:00-19:00"
        }
      ]
    }
  end
end
