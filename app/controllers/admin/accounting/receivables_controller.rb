class Admin::Accounting::ReceivablesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "売上・債権管理", path: admin_accounting_receivables_path }
    ]

    # KPIサマリー
    @summary = {
      total_sales: 145_800_000,
      outstanding_amount: 45_500_000,
      overdue_amount: 8_500_000,
      invoice_count: 18,
      average_collection_days: 38,
      collection_rate: 68.8
    }

    # 売上・債権一覧
    @receivables = [
      {
        id: 1,
        invoice_number: "INV-2025-11-001",
        invoice_date: "2025-11-01",
        client: "株式会社サンプルテクノロジー",
        project: "ECサイトリニューアル",
        sales_amount: 15_000_000,
        tax: 1_500_000,
        total: 16_500_000,
        due_date: "2025-11-30",
        payment_date: nil,
        status: "未入金",
        days_outstanding: 12,
        alert: false
      },
      {
        id: 2,
        invoice_number: "INV-2025-11-002",
        invoice_date: "2025-11-05",
        client: "株式会社ビッグデータソリューションズ",
        project: "データ分析基盤構築",
        sales_amount: 20_000_000,
        tax: 2_000_000,
        total: 22_000_000,
        due_date: "2025-12-05",
        payment_date: nil,
        status: "未入金",
        days_outstanding: 7,
        alert: false
      },
      {
        id: 3,
        invoice_number: "INV-2025-10-015",
        invoice_date: "2025-10-20",
        client: "株式会社メガコーポレーション",
        project: "社内業務システム開発",
        sales_amount: 8_500_000,
        tax: 850_000,
        total: 9_350_000,
        due_date: "2025-10-31",
        payment_date: nil,
        status: "滞留",
        days_outstanding: 42,
        alert: true
      },
      {
        id: 4,
        invoice_number: "INV-2025-10-012",
        invoice_date: "2025-10-15",
        client: "株式会社セキュアシステムズ",
        project: "セキュリティ診断",
        sales_amount: 3_500_000,
        tax: 350_000,
        total: 3_850_000,
        due_date: "2025-11-15",
        payment_date: "2025-11-10",
        status: "入金済",
        days_outstanding: 0,
        alert: false
      },
      {
        id: 5,
        invoice_number: "INV-2025-10-008",
        invoice_date: "2025-10-10",
        client: "株式会社効率化ソリューション",
        project: "業務効率化コンサル",
        sales_amount: 4_500_000,
        tax: 450_000,
        total: 4_950_000,
        due_date: "2025-11-10",
        payment_date: "2025-11-08",
        status: "入金済",
        days_outstanding: 0,
        alert: false
      }
    ]

    # 入金予定
    @scheduled_payments = [
      { date: "2025-11-30", client: "株式会社サンプルテクノロジー", amount: 16_500_000 },
      { date: "2025-12-05", client: "株式会社ビッグデータソリューションズ", amount: 22_000_000 },
      { date: "2025-12-10", client: "株式会社イノベーション", amount: 27_500_000 }
    ]

    # 滞留債権
    @overdue_receivables = [
      {
        client: "株式会社メガコーポレーション",
        invoice_number: "INV-2025-10-015",
        amount: 9_350_000,
        days_overdue: 12,
        last_contact: "2025-11-15"
      }
    ]

    # 月別売上推移
    @monthly_sales = [
      { month: "2025-06", amount: 95_000_000, collection: 88_000_000, rate: 92.6 },
      { month: "2025-07", amount: 105_000_000, collection: 98_000_000, rate: 93.3 },
      { month: "2025-08", amount: 98_000_000, collection: 92_000_000, rate: 93.9 },
      { month: "2025-09", amount: 115_000_000, collection: 105_000_000, rate: 91.3 },
      { month: "2025-10", amount: 140_000_000, collection: 120_000_000, rate: 85.7 },
      { month: "2025-11", amount: 145_800_000, collection: 100_300_000, rate: 68.8 }
    ]
  end
end
