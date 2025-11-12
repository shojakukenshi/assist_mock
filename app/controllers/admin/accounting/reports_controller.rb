class Admin::Accounting::ReportsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "法定調書・報告書", path: admin_accounting_reports_path }
    ]

    # KPIサマリー
    @summary = {
      total_reports: 28,
      completed: 20,
      pending: 5,
      overdue: 3,
      completion_rate: 71.4
    }

    # 法定調書・報告書一覧
    @reports = [
      {
        id: 1,
        report_type: "給与支払報告書",
        target_period: "2024年度",
        deadline: "2025-01-31",
        status: "提出済",
        created_date: "2025-01-20",
        submitted_date: "2025-01-25",
        submitted_by: "経理部長",
        output_format: "e-Tax",
        remarks: nil
      },
      {
        id: 2,
        report_type: "法定調書合計表",
        target_period: "2024年度",
        deadline: "2025-01-31",
        status: "提出済",
        created_date: "2025-01-18",
        submitted_date: "2025-01-25",
        submitted_by: "経理部長",
        output_format: "e-Tax",
        remarks: nil
      },
      {
        id: 3,
        report_type: "源泉徴収票",
        target_period: "2024年度",
        deadline: "2025-01-31",
        status: "提出済",
        created_date: "2025-01-15",
        submitted_date: "2025-01-28",
        submitted_by: "経理部長",
        output_format: "PDF",
        remarks: "従業員45名分"
      },
      {
        id: 4,
        report_type: "支払調書",
        target_period: "2024年度",
        deadline: "2025-01-31",
        status: "提出済",
        created_date: "2025-01-10",
        submitted_date: "2025-01-28",
        submitted_by: "経理部長",
        output_format: "e-Tax",
        remarks: "外注先12社分"
      },
      {
        id: 5,
        report_type: "消費税申告書",
        target_period: "2024年10-12月",
        deadline: "2025-01-31",
        status: "提出済",
        created_date: "2025-01-22",
        submitted_date: "2025-01-30",
        submitted_by: "経理部長",
        output_format: "e-Tax",
        remarks: nil
      },
      {
        id: 6,
        report_type: "労働保険料申告書",
        target_period: "2024年度",
        deadline: "2024-07-10",
        status: "提出済",
        created_date: "2024-06-25",
        submitted_date: "2024-07-05",
        submitted_by: "経理部長",
        output_format: "e-Gov",
        remarks: nil
      },
      {
        id: 7,
        report_type: "算定基礎届",
        target_period: "2024年7月",
        deadline: "2024-07-10",
        status: "提出済",
        created_date: "2024-06-28",
        submitted_date: "2024-07-08",
        submitted_by: "経理部長",
        output_format: "e-Gov",
        remarks: nil
      },
      {
        id: 8,
        report_type: "法人税申告書",
        target_period: "2024年度",
        deadline: "2025-05-31",
        status: "未作成",
        created_date: nil,
        submitted_date: nil,
        submitted_by: nil,
        output_format: nil,
        remarks: "作成準備中"
      },
      {
        id: 9,
        report_type: "消費税申告書",
        target_period: "2025年1-3月",
        deadline: "2025-04-30",
        status: "未作成",
        created_date: nil,
        submitted_date: nil,
        submitted_by: nil,
        output_format: nil,
        remarks: nil
      },
      {
        id: 10,
        report_type: "給与支払報告書",
        target_period: "2025年度",
        deadline: "2026-01-31",
        status: "未作成",
        created_date: nil,
        submitted_date: nil,
        submitted_by: nil,
        output_format: nil,
        remarks: nil
      },
      {
        id: 11,
        report_type: "月次報告（健康保険・厚生年金）",
        target_period: "2025年11月",
        deadline: "2025-12-10",
        status: "作成中",
        created_date: "2025-11-25",
        submitted_date: nil,
        submitted_by: nil,
        output_format: "e-Gov",
        remarks: "確認中"
      },
      {
        id: 12,
        report_type: "源泉所得税納付書",
        target_period: "2025年11月",
        deadline: "2025-12-10",
        status: "作成中",
        created_date: "2025-11-28",
        submitted_date: nil,
        submitted_by: nil,
        output_format: "PDF",
        remarks: nil
      },
      {
        id: 13,
        report_type: "住民税納付書",
        target_period: "2025年11月",
        deadline: "2025-12-10",
        status: "未提出",
        created_date: "2025-11-20",
        submitted_date: nil,
        submitted_by: nil,
        output_format: "PDF",
        remarks: "期限接近"
      }
    ]

    # 提出期限アラート
    @deadline_alerts = [
      {
        report_type: "住民税納付書",
        deadline: "2025-12-10",
        days_remaining: 10,
        priority: "高"
      },
      {
        report_type: "月次報告（健康保険・厚生年金）",
        deadline: "2025-12-10",
        days_remaining: 10,
        priority: "高"
      },
      {
        report_type: "源泉所得税納付書",
        deadline: "2025-12-10",
        days_remaining: 10,
        priority: "中"
      }
    ]

    # 提出済み件数推移（月次）
    @submission_trends = [
      { month: "2025-06", submitted: 4, total: 5, rate: 80.0 },
      { month: "2025-07", submitted: 3, total: 4, rate: 75.0 },
      { month: "2025-08", submitted: 2, total: 2, rate: 100.0 },
      { month: "2025-09", submitted: 3, total: 3, rate: 100.0 },
      { month: "2025-10", submitted: 2, total: 3, rate: 66.7 },
      { month: "2025-11", submitted: 1, total: 4, rate: 25.0 }
    ]
  end
end
