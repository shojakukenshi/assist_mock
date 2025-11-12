class Admin::Accounting::PayrollsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path }
    ]

    # 対象期間
    @period = params[:period] || Date.today.strftime("%Y-%m")

    # KPIサマリー
    @summary = {
      total_payrolls: 45,
      unpaid: 8,
      immediate_payment: 3,
      total_amount: 28_500_000,
      unpaid_amount: 5_200_000,
      processing_rate: 82.2
    }

    # 給与一覧データ
    @payrolls = [
      {
        id: 1,
        employee_name: "佐藤太郎",
        employee_code: "EMP001",
        department: "営業部",
        base_salary: 350_000,
        allowances: 50_000,
        overtime_pay: 45_000,
        total_gross: 445_000,
        deductions: 89_000,
        net_salary: 356_000,
        payment_date: "2025-11-25",
        status: "支払済",
        payment_method: "銀行振込",
        bank_name: "三菱UFJ銀行",
        account_number: "1234567"
      },
      {
        id: 2,
        employee_name: "田中花子",
        employee_code: "EMP002",
        department: "経理部",
        base_salary: 380_000,
        allowances: 45_000,
        overtime_pay: 32_000,
        total_gross: 457_000,
        deductions: 91_400,
        net_salary: 365_600,
        payment_date: "2025-11-25",
        status: "支払済",
        payment_method: "銀行振込",
        bank_name: "みずほ銀行",
        account_number: "2345678"
      },
      {
        id: 3,
        employee_name: "鈴木次郎",
        employee_code: "EMP003",
        department: "技術部",
        base_salary: 420_000,
        allowances: 60_000,
        overtime_pay: 58_000,
        total_gross: 538_000,
        deductions: 107_600,
        net_salary: 430_400,
        payment_date: "2025-11-25",
        status: "未払い",
        payment_method: "銀行振込",
        bank_name: "三井住友銀行",
        account_number: "3456789"
      },
      {
        id: 4,
        employee_name: "高橋美咲",
        employee_code: "EMP004",
        department: "営業部",
        base_salary: 340_000,
        allowances: 40_000,
        overtime_pay: 28_000,
        total_gross: 408_000,
        deductions: 81_600,
        net_salary: 326_400,
        payment_date: "2025-11-25",
        status: "未払い",
        payment_method: "銀行振込",
        bank_name: "りそな銀行",
        account_number: "4567890"
      },
      {
        id: 5,
        employee_name: "伊藤健太",
        employee_code: "EMP005",
        department: "人事部",
        base_salary: 390_000,
        allowances: 55_000,
        overtime_pay: 38_000,
        total_gross: 483_000,
        deductions: 96_600,
        net_salary: 386_400,
        payment_date: "2025-11-25",
        status: "未払い",
        payment_method: "銀行振込",
        bank_name: "三菱UFJ銀行",
        account_number: "5678901"
      },
      {
        id: 6,
        employee_name: "山田一郎",
        employee_code: "EMP006",
        department: "技術部",
        base_salary: 450_000,
        allowances: 70_000,
        overtime_pay: 62_000,
        total_gross: 582_000,
        deductions: 116_400,
        net_salary: 465_600,
        payment_date: "2025-11-25",
        status: "即払い済",
        payment_method: "即時振込",
        bank_name: "PayPay銀行",
        account_number: "6789012",
        immediate_payment_date: "2025-11-20"
      },
      {
        id: 7,
        employee_name: "渡辺美咲",
        employee_code: "EMP007",
        department: "経理部",
        base_salary: 360_000,
        allowances: 48_000,
        overtime_pay: 35_000,
        total_gross: 443_000,
        deductions: 88_600,
        net_salary: 354_400,
        payment_date: "2025-11-25",
        status: "支払済",
        payment_method: "銀行振込",
        bank_name: "ゆうちょ銀行",
        account_number: "7890123"
      },
      {
        id: 8,
        employee_name: "中村太郎",
        employee_code: "EMP008",
        department: "営業部",
        base_salary: 330_000,
        allowances: 42_000,
        overtime_pay: 25_000,
        total_gross: 397_000,
        deductions: 79_400,
        net_salary: 317_600,
        payment_date: "2025-11-25",
        status: "未払い",
        payment_method: "銀行振込",
        bank_name: "三菱UFJ銀行",
        account_number: "8901234"
      },
      {
        id: 9,
        employee_name: "小林花子",
        employee_code: "EMP009",
        department: "総務部",
        base_salary: 370_000,
        allowances: 50_000,
        overtime_pay: 40_000,
        total_gross: 460_000,
        deductions: 92_000,
        net_salary: 368_000,
        payment_date: "2025-11-25",
        status: "未払い",
        payment_method: "銀行振込",
        bank_name: "みずほ銀行",
        account_number: "9012345"
      },
      {
        id: 10,
        employee_name: "加藤健太",
        employee_code: "EMP010",
        department: "技術部",
        base_salary: 440_000,
        allowances: 65_000,
        overtime_pay: 55_000,
        total_gross: 560_000,
        deductions: 112_000,
        net_salary: 448_000,
        payment_date: "2025-11-25",
        status: "即払い申請中",
        payment_method: "即時振込",
        bank_name: "楽天銀行",
        account_number: "0123456",
        immediate_payment_requested: "2025-11-22"
      }
    ]

    # 部門別集計
    @department_summary = [
      { department: "営業部", count: 12, amount: 4_200_000 },
      { department: "技術部", count: 15, amount: 6_800_000 },
      { department: "経理部", count: 8, amount: 2_900_000 },
      { department: "人事部", count: 5, amount: 1_900_000 },
      { department: "総務部", count: 5, amount: 1_700_000 }
    ]
  end
end
