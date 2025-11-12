class Admin::Accounting::ExpensesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "経費・仕入管理", path: admin_accounting_expenses_path }
    ]

    # KPIサマリー
    @summary = {
      pending_expenses: 12,
      pending_purchases: 8,
      monthly_expense_total: 1_850_000,
      monthly_purchase_total: 5_200_000,
      approval_rate: 85.0
    }

    # 経費申請データ（営業部門から経理承認待ち）
    @expense_requests = [
      {
        id: 1,
        request_date: "2025-11-20",
        employee_name: "佐藤花子",
        department: "営業部",
        category: "交通費",
        description: "クライアント訪問（東京→大阪）",
        amount: 29_000,
        receipt: true,
        status: "承認待ち",
        requested_by: "佐藤花子",
        approver: "経理部長"
      },
      {
        id: 2,
        request_date: "2025-11-19",
        employee_name: "田中次郎",
        department: "営業部",
        category: "接待交際費",
        description: "取引先との会食",
        amount: 18_500,
        receipt: true,
        status: "承認待ち",
        requested_by: "田中次郎",
        approver: "経理部長"
      },
      {
        id: 3,
        request_date: "2025-11-18",
        employee_name: "鈴木美咲",
        department: "技術部",
        category: "消耗品費",
        description: "開発用機材購入",
        amount: 125_000,
        receipt: true,
        status: "承認済",
        requested_by: "鈴木美咲",
        approver: "経理部長",
        approved_date: "2025-11-19"
      },
      {
        id: 4,
        request_date: "2025-11-17",
        employee_name: "伊藤健太",
        department: "人事部",
        category: "会議費",
        description: "採用面接会場費用",
        amount: 15_000,
        receipt: true,
        status: "差戻し",
        requested_by: "伊藤健太",
        approver: "経理部長",
        reject_reason: "領収書の日付が不明瞭です"
      }
    ]

    # 仕入データ
    @purchases = [
      {
        id: 1,
        purchase_date: "2025-11-15",
        supplier: "株式会社オフィス用品",
        category: "消耗品",
        description: "事務用品一式",
        amount: 85_000,
        tax: 8_500,
        total: 93_500,
        payment_due: "2025-12-15",
        status: "未払い"
      },
      {
        id: 2,
        purchase_date: "2025-11-10",
        supplier: "株式会社ITソリューションズ",
        category: "ソフトウェア",
        description: "ライセンス更新費用",
        amount: 350_000,
        tax: 35_000,
        total: 385_000,
        payment_due: "2025-12-10",
        status: "未払い"
      },
      {
        id: 3,
        purchase_date: "2025-11-05",
        supplier: "ABC商事株式会社",
        category: "備品",
        description: "会議室用椅子",
        amount: 180_000,
        tax: 18_000,
        total: 198_000,
        payment_due: "2025-12-05",
        status: "支払済",
        payment_date: "2025-11-30"
      },
      {
        id: 4,
        purchase_date: "2025-11-01",
        supplier: "株式会社清掃サービス",
        category: "外注費",
        description: "オフィス清掃（11月分）",
        amount: 45_000,
        tax: 4_500,
        total: 49_500,
        payment_due: "2025-11-30",
        status: "支払済",
        payment_date: "2025-11-28"
      }
    ]

    # 費目別集計
    @category_summary = [
      { category: "交通費", count: 25, amount: 285_000 },
      { category: "接待交際費", count: 8, amount: 420_000 },
      { category: "消耗品費", count: 15, amount: 680_000 },
      { category: "会議費", count: 6, amount: 95_000 },
      { category: "通信費", count: 12, amount: 180_000 },
      { category: "その他", count: 10, amount: 190_000 }
    ]
  end
end
