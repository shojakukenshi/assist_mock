class Admin::Sales::AnalyticsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "営業管理", path: admin_sales_pipeline_path },
      { name: "営業分析レポート", path: admin_sales_analytics_path }
    ]

    # 期間フィルター
    @periods = ["今月", "前月", "今四半期", "前四半期", "今年度", "前年度"]
    @selected_period = "今月"

    # KPIサマリー
    @kpis = {
      total_revenue: 145_800_000,
      profit_margin: 28.5,
      success_rate: 75.0,
      active_deals: 24,
      new_deals: 8,
      closed_deals: 12
    }

    # 月別売上推移（12ヶ月）
    @monthly_revenue = [
      { month: "2024-12", revenue: 95_000_000, profit: 27_000_000, deals: 18 },
      { month: "2025-01", revenue: 105_000_000, profit: 30_000_000, deals: 20 },
      { month: "2025-02", revenue: 98_000_000, profit: 28_000_000, deals: 19 },
      { month: "2025-03", revenue: 115_000_000, profit: 33_000_000, deals: 22 },
      { month: "2025-04", revenue: 108_000_000, profit: 31_000_000, deals: 21 },
      { month: "2025-05", revenue: 120_000_000, profit: 34_000_000, deals: 23 },
      { month: "2025-06", revenue: 125_000_000, profit: 36_000_000, deals: 24 },
      { month: "2025-07", revenue: 118_000_000, profit: 34_000_000, deals: 22 },
      { month: "2025-08", revenue: 130_000_000, profit: 37_000_000, deals: 25 },
      { month: "2025-09", revenue: 135_000_000, profit: 39_000_000, deals: 26 },
      { month: "2025-10", revenue: 140_000_000, profit: 40_000_000, deals: 27 },
      { month: "2025-11", revenue: 145_800_000, profit: 41_500_000, deals: 24 }
    ]

    # ステージ別案件分布
    @stage_distribution = [
      { stage: "商談中", count: 8, amount: 32_800_000, percentage: 22.5 },
      { stage: "見積中", count: 5, amount: 25_000_000, percentage: 17.1 },
      { stage: "受注", count: 6, amount: 60_000_000, percentage: 41.2 },
      { stage: "納品", count: 3, amount: 9_500_000, percentage: 6.5 },
      { stage: "請求完了", count: 2, amount: 18_500_000, percentage: 12.7 }
    ]

    # 営業担当者別実績
    @sales_performance = [
      {
        name: "佐藤花子",
        deals: 8,
        revenue: 58_000_000,
        profit: 16_500_000,
        success_rate: 80.0,
        average_deal: 7_250_000
      },
      {
        name: "田中次郎",
        deals: 6,
        revenue: 42_000_000,
        profit: 12_000_000,
        success_rate: 75.0,
        average_deal: 7_000_000
      },
      {
        name: "伊藤健太",
        deals: 7,
        revenue: 36_500_000,
        profit: 10_500_000,
        success_rate: 70.0,
        average_deal: 5_214_000
      },
      {
        name: "鈴木美咲",
        deals: 3,
        revenue: 9_300_000,
        profit: 2_500_000,
        success_rate: 60.0,
        average_deal: 3_100_000
      }
    ]

    # 業種別売上分布
    @industry_revenue = [
      { industry: "IT・通信", revenue: 85_000_000, percentage: 58.3, deals: 14 },
      { industry: "製造業", revenue: 26_500_000, percentage: 18.2, deals: 4 },
      { industry: "金融", revenue: 18_000_000, percentage: 12.3, deals: 3 },
      { industry: "サービス", revenue: 10_500_000, percentage: 7.2, deals: 2 },
      { industry: "その他", revenue: 5_800_000, percentage: 4.0, deals: 1 }
    ]

    # 案件規模別分布
    @deal_size_distribution = [
      { range: "1,000万円未満", count: 8, amount: 35_000_000, percentage: 24.0 },
      { range: "1,000万円〜3,000万円", count: 10, amount: 65_000_000, percentage: 44.6 },
      { range: "3,000万円以上", count: 6, amount: 45_800_000, percentage: 31.4 }
    ]

    # リードタイム分析
    @lead_time_stats = {
      average_days: 45,
      median_days: 38,
      shortest_days: 15,
      longest_days: 90,
      by_stage: {
        negotiation_to_estimate: 12,
        estimate_to_order: 18,
        order_to_delivery: 10,
        delivery_to_billing: 5
      }
    }

    # 月次目標達成率
    @monthly_targets = [
      { month: "2025-08", target: 120_000_000, actual: 130_000_000, rate: 108.3 },
      { month: "2025-09", target: 130_000_000, actual: 135_000_000, rate: 103.8 },
      { month: "2025-10", target: 135_000_000, actual: 140_000_000, rate: 103.7 },
      { month: "2025-11", target: 140_000_000, actual: 145_800_000, rate: 104.1 }
    ]
  end
end
