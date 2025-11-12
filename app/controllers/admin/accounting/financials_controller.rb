class Admin::Accounting::FinancialsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "財務管理・決算処理", path: admin_accounting_financials_path }
    ]

    # 対象期間
    @period = params[:period] || Date.today.strftime("%Y-%m")
    @fiscal_year = params[:fiscal_year] || "2025"

    # KPIサマリー
    @summary = {
      profit_margin: 28.5,
      gross_margin: 42.3,
      expense_ratio: 13.8,
      closing_progress: 75.0,
      net_profit: 41_500_000,
      total_revenue: 145_800_000
    }

    # 月次締め処理履歴
    @closing_history = [
      {
        period: "2025-10",
        closed_date: "2025-11-05",
        closed_by: "経理部長",
        status: "締め済",
        revenue: 140_000_000,
        expense: 98_000_000,
        profit: 42_000_000
      },
      {
        period: "2025-09",
        closed_date: "2025-10-05",
        closed_by: "経理部長",
        status: "締め済",
        revenue: 135_000_000,
        expense: 94_500_000,
        profit: 40_500_000
      },
      {
        period: "2025-11",
        closed_date: nil,
        closed_by: nil,
        status: "処理中",
        revenue: 145_800_000,
        expense: 104_300_000,
        profit: 41_500_000
      }
    ]

    # 損益計算書データ
    @profit_loss = {
      revenue: {
        sales: 145_800_000,
        other_income: 2_500_000,
        total: 148_300_000
      },
      cost_of_sales: {
        labor_cost: 58_000_000,
        outsourcing: 12_500_000,
        total: 70_500_000
      },
      gross_profit: 77_800_000,
      expenses: {
        personnel: 28_500_000,
        rent: 8_500_000,
        utilities: 1_800_000,
        travel: 2_200_000,
        advertising: 3_500_000,
        other: 5_800_000,
        total: 50_300_000
      },
      operating_profit: 27_500_000,
      non_operating: {
        interest_income: 150_000,
        interest_expense: -280_000,
        total: -130_000
      },
      ordinary_profit: 27_370_000,
      extraordinary: {
        gain: 0,
        loss: 0,
        total: 0
      },
      net_profit_before_tax: 27_370_000,
      corporate_tax: 8_211_000,
      net_profit: 19_159_000
    }

    # 貸借対照表データ（簡易版）
    @balance_sheet = {
      assets: {
        current: 85_000_000,
        fixed: 45_000_000,
        total: 130_000_000
      },
      liabilities: {
        current: 35_000_000,
        long_term: 20_000_000,
        total: 55_000_000
      },
      equity: {
        capital: 50_000_000,
        retained_earnings: 25_000_000,
        total: 75_000_000
      }
    }

    # 月次損益推移（12ヶ月）
    @monthly_pl_trends = [
      { month: "2024-12", revenue: 95_000_000, expense: 66_500_000, profit: 28_500_000 },
      { month: "2025-01", revenue: 105_000_000, expense: 73_500_000, profit: 31_500_000 },
      { month: "2025-02", revenue: 98_000_000, expense: 68_600_000, profit: 29_400_000 },
      { month: "2025-03", revenue: 115_000_000, expense: 80_500_000, profit: 34_500_000 },
      { month: "2025-04", revenue: 108_000_000, expense: 75_600_000, profit: 32_400_000 },
      { month: "2025-05", revenue: 120_000_000, expense: 84_000_000, profit: 36_000_000 },
      { month: "2025-06", revenue: 125_000_000, expense: 87_500_000, profit: 37_500_000 },
      { month: "2025-07", revenue: 118_000_000, expense: 82_600_000, profit: 35_400_000 },
      { month: "2025-08", revenue: 130_000_000, expense: 91_000_000, profit: 39_000_000 },
      { month: "2025-09", revenue: 135_000_000, expense: 94_500_000, profit: 40_500_000 },
      { month: "2025-10", revenue: 140_000_000, expense: 98_000_000, profit: 42_000_000 },
      { month: "2025-11", revenue: 145_800_000, expense: 104_300_000, profit: 41_500_000 }
    ]

    # 決算仕訳データ
    @adjustment_entries = [
      {
        date: "2025-11-30",
        description: "減価償却費計上",
        debit_account: "減価償却費",
        credit_account: "減価償却累計額",
        amount: 580_000,
        status: "未処理"
      },
      {
        date: "2025-11-30",
        description: "前払費用振替",
        debit_account: "前払費用",
        credit_account: "通信費",
        amount: 150_000,
        status: "未処理"
      }
    ]
  end
end
