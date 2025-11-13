class Admin::Accounting::InsuranceController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "社会保険・税務管理", path: admin_accounting_insurance_index_path }
    ]

    # KPIサマリー
    @summary = {
      total_employees: 45,
      pending_filings: 5,
      total_insurance_payment: 3_850_000,
      total_tax_payment: 2_150_000,
      completion_rate: 88.9
    }

    # 保険料データ
    @insurance_data = [
      {
        employee_name: "佐藤太郎",
        employee_code: "EMP001",
        health_insurance: 18_500,
        pension: 36_200,
        employment_insurance: 1_335,
        total: 56_035,
        status: "確定"
      },
      {
        employee_name: "田中花子",
        employee_code: "EMP002",
        health_insurance: 19_800,
        pension: 38_760,
        employment_insurance: 1_371,
        total: 59_931,
        status: "確定"
      },
      {
        employee_name: "鈴木次郎",
        employee_code: "EMP003",
        health_insurance: 22_000,
        pension: 43_120,
        employment_insurance: 1_614,
        total: 66_734,
        status: "未確定"
      }
    ]

    # 税務データ
    @tax_data = [
      {
        employee_name: "佐藤太郎",
        employee_code: "EMP001",
        income_tax: 12_500,
        resident_tax: 18_300,
        total: 30_800,
        status: "納付済"
      },
      {
        employee_name: "田中花子",
        employee_code: "EMP002",
        income_tax: 13_200,
        resident_tax: 19_500,
        total: 32_700,
        status: "納付済"
      },
      {
        employee_name: "鈴木次郎",
        employee_code: "EMP003",
        income_tax: 15_800,
        resident_tax: 22_100,
        total: 37_900,
        status: "未納付"
      }
    ]

    # 年末調整データ
    @year_end_adjustment = [
      {
        employee_name: "佐藤太郎",
        employee_code: "EMP001",
        status: "提出済",
        dependents: 2,
        insurance_deduction: 120_000,
        total_deduction: 380_000,
        refund_amount: 45_000
      },
      {
        employee_name: "田中花子",
        employee_code: "EMP002",
        status: "提出済",
        dependents: 1,
        insurance_deduction: 80_000,
        total_deduction: 250_000,
        refund_amount: 28_000
      },
      {
        employee_name: "鈴木次郎",
        employee_code: "EMP003",
        status: "未提出",
        dependents: 0,
        insurance_deduction: nil,
        total_deduction: nil,
        refund_amount: nil
      }
    ]

    # 月次納付金額推移
    @monthly_payments = [
      { month: "2025-06", insurance: 3_650_000, tax: 2_050_000 },
      { month: "2025-07", insurance: 3_720_000, tax: 2_080_000 },
      { month: "2025-08", insurance: 3_780_000, tax: 2_120_000 },
      { month: "2025-09", insurance: 3_800_000, tax: 2_100_000 },
      { month: "2025-10", insurance: 3_825_000, tax: 2_130_000 },
      { month: "2025-11", insurance: 3_850_000, tax: 2_150_000 }
    ]
  end
end
