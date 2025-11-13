class Admin::Accounting::PayrollsController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path }
    ]

    # 過去の給与計算期間レコード
    @payroll_periods = [
      {
        id: 1,
        period: "2025-11",
        period_start: "2025-11-01",
        period_end: "2025-11-30",
        staff_count: 158,
        total_amount: 52_800_000,
        status_calculate: "完了",
        status_generate_slips: "完了",
        status_transfer: "完了",
        calculated_at: "2025-11-28 10:00",
        slips_generated_at: "2025-11-28 14:30",
        transferred_at: "2025-11-29 09:00",
        created_by: "小林誠"
      },
      {
        id: 2,
        period: "2025-10",
        period_start: "2025-10-01",
        period_end: "2025-10-31",
        staff_count: 165,
        total_amount: 51_200_000,
        status_calculate: "完了",
        status_generate_slips: "完了",
        status_transfer: "完了",
        calculated_at: "2025-10-28 10:00",
        slips_generated_at: "2025-10-28 14:30",
        transferred_at: "2025-10-29 09:00",
        created_by: "小林誠"
      },
      {
        id: 3,
        period: "2025-09",
        period_start: "2025-09-01",
        period_end: "2025-09-30",
        staff_count: 160,
        total_amount: 48_600_000,
        status_calculate: "完了",
        status_generate_slips: "完了",
        status_transfer: "完了",
        calculated_at: "2025-09-28 10:00",
        slips_generated_at: "2025-09-28 14:30",
        transferred_at: "2025-09-29 09:00",
        created_by: "小林誠"
      },
      {
        id: 4,
        period: "2025-12",
        period_start: "2025-12-01",
        period_end: "2025-12-31",
        staff_count: 170,
        total_amount: 0,
        status_calculate: "進行中",
        status_generate_slips: "未着手",
        status_transfer: "未着手",
        calculated_at: nil,
        slips_generated_at: nil,
        transferred_at: nil,
        created_by: "小林誠"
      }
    ]

    # サマリー
    @summary = {
      total_periods: 4,
      completed_periods: 3,
      in_progress: 1,
      total_paid_this_year: 152_600_000,
      total_staff: 170
    }
  end

  def new
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "新規給与計算", path: new_admin_accounting_payroll_path }
    ]

    # 次の給与計算期間を自動設定
    @suggested_period = {
      period_start: Date.today.beginning_of_month,
      period_end: Date.today.end_of_month
    }
  end

  def show
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "給与計算詳細", path: admin_accounting_payroll_path(params[:id]) }
    ]

    # 給与計算期間レコード（モックデータ）
    @payroll_period = {
      id: params[:id].to_i,
      period: "2025-12",
      period_start: "2025-12-01",
      period_end: "2025-12-31",
      staff_count: 170,
      total_amount: 55_200_000,
      status_calculate: params[:id].to_i == 4 ? "進行中" : "完了",
      status_generate_slips: params[:id].to_i == 4 ? "未着手" : "完了",
      status_transfer: params[:id].to_i == 4 ? "未着手" : "完了",
      calculated_at: params[:id].to_i == 4 ? nil : "2025-12-28 10:00",
      slips_generated_at: params[:id].to_i == 4 ? nil : "2025-12-28 14:30",
      transferred_at: params[:id].to_i == 4 ? nil : "2025-12-29 09:00",
      created_by: "小林誠"
    }

    # 現在のステップを判定
    @current_step = determine_current_step(@payroll_period)
  end

  # ステップ1: 給与計算
  def wizard_step1
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "給与計算", path: wizard_step1_admin_accounting_payroll_path(params[:id]) }
    ]

    @payroll_period = get_payroll_period(params[:id].to_i)

    # スタッフ別給与計算データ（イベントスタッフ派遣業務）
    @staff_payrolls = [
      {
        id: 1,
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        total_work_hours: 168.5,
        hourly_rate: 3_500,
        gross_pay: 589_750,
        social_insurance: 58_975,
        income_tax: 11_795,
        total_deductions: 70_770,
        net_pay: 518_980,
        work_days: 22,
        projects: ["東京モーターショー2025", "企業セミナー運営"]
      },
      {
        id: 2,
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        total_work_hours: 145.0,
        hourly_rate: 3_000,
        gross_pay: 435_000,
        social_insurance: 43_500,
        income_tax: 8_700,
        total_deductions: 52_200,
        net_pay: 382_800,
        work_days: 18,
        projects: ["結婚式サポート", "ブライダルフェア"]
      },
      {
        id: 3,
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        total_work_hours: 0,
        hourly_rate: 4_000,
        gross_pay: 0,
        social_insurance: 0,
        income_tax: 0,
        total_deductions: 0,
        net_pay: 0,
        work_days: 0,
        projects: []
      },
      {
        id: 4,
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        total_work_hours: 132.0,
        hourly_rate: 2_800,
        gross_pay: 369_600,
        social_insurance: 36_960,
        income_tax: 7_392,
        total_deductions: 44_352,
        net_pay: 325_248,
        work_days: 16,
        projects: ["企業セミナー運営"]
      },
      {
        id: 5,
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        total_work_hours: 156.0,
        hourly_rate: 3_200,
        gross_pay: 499_200,
        social_insurance: 49_920,
        income_tax: 9_984,
        total_deductions: 59_904,
        net_pay: 439_296,
        work_days: 20,
        projects: ["音楽フェスティバル運営", "マラソン大会サポート"]
      },
      {
        id: 6,
        staff_code: "ST-0006",
        staff_name: "伊藤里奈",
        total_work_hours: 88.0,
        hourly_rate: 2_900,
        gross_pay: 255_200,
        social_insurance: 25_520,
        income_tax: 5_104,
        total_deductions: 30_624,
        net_pay: 224_576,
        work_days: 11,
        projects: ["展示会受付"]
      },
      {
        id: 7,
        staff_code: "ST-0007",
        staff_name: "渡辺翔太",
        total_work_hours: 142.0,
        hourly_rate: 3_300,
        gross_pay: 468_600,
        social_insurance: 46_860,
        income_tax: 9_372,
        total_deductions: 56_232,
        net_pay: 412_368,
        work_days: 18,
        projects: ["国際会議サポート"]
      },
      {
        id: 8,
        staff_code: "ST-0008",
        staff_name: "小林由美",
        total_work_hours: 0,
        hourly_rate: 3_400,
        gross_pay: 0,
        social_insurance: 0,
        income_tax: 0,
        total_deductions: 0,
        net_pay: 0,
        work_days: 0,
        projects: []
      },
      {
        id: 9,
        staff_code: "ST-0009",
        staff_name: "中村健",
        total_work_hours: 96.0,
        hourly_rate: 2_500,
        gross_pay: 240_000,
        social_insurance: 24_000,
        income_tax: 4_800,
        total_deductions: 28_800,
        net_pay: 211_200,
        work_days: 12,
        projects: ["展示会誘導"]
      },
      {
        id: 10,
        staff_code: "ST-0010",
        staff_name: "加藤大介",
        total_work_hours: 164.0,
        hourly_rate: 3_000,
        gross_pay: 492_000,
        social_insurance: 49_200,
        income_tax: 9_840,
        total_deductions: 59_040,
        net_pay: 432_960,
        work_days: 21,
        projects: ["マラソン大会運営サポート"]
      }
    ]

    # 集計データ
    @calculation_summary = {
      total_staff: @staff_payrolls.count,
      working_staff: @staff_payrolls.count { |s| s[:work_days] > 0 },
      total_work_hours: @staff_payrolls.sum { |s| s[:total_work_hours] },
      total_gross_pay: @staff_payrolls.sum { |s| s[:gross_pay] },
      total_deductions: @staff_payrolls.sum { |s| s[:total_deductions] },
      total_net_pay: @staff_payrolls.sum { |s| s[:net_pay] }
    }
  end

  def execute_step1
    # 実際の給与計算処理（モックなのでスキップ）
    flash[:success] = "給与計算が完了しました。"
    redirect_to wizard_step2_admin_accounting_payroll_path(params[:id])
  end

  # ステップ2: 給与明細発行
  def wizard_step2
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "給与明細発行", path: wizard_step2_admin_accounting_payroll_path(params[:id]) }
    ]

    @payroll_period = get_payroll_period(params[:id].to_i)

    # スタッフ別給与明細発行状況
    @staff_slips = [
      {
        id: 1,
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        net_pay: 518_980,
        email: "yamamoto@staff.example.com",
        slip_status: "未発行",
        mypage_access: "可能"
      },
      {
        id: 2,
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        net_pay: 382_800,
        email: "suzuki@staff.example.com",
        slip_status: "未発行",
        mypage_access: "可能"
      },
      {
        id: 3,
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        net_pay: 0,
        email: "tanaka@staff.example.com",
        slip_status: "対象外",
        mypage_access: "可能"
      },
      {
        id: 4,
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        net_pay: 325_248,
        email: "sato.m@staff.example.com",
        slip_status: "未発行",
        mypage_access: "可能"
      },
      {
        id: 5,
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        net_pay: 439_296,
        email: "takahashi@staff.example.com",
        slip_status: "未発行",
        mypage_access: "可能"
      }
    ]

    @slip_summary = {
      total_staff: @staff_slips.count,
      target_staff: @staff_slips.count { |s| s[:slip_status] != "対象外" },
      issued: 0,
      not_issued: @staff_slips.count { |s| s[:slip_status] == "未発行" }
    }
  end

  def execute_step2
    # 実際の給与明細発行処理（モックなのでスキップ）
    flash[:success] = "給与明細を発行しました。"
    redirect_to wizard_step3_admin_accounting_payroll_path(params[:id])
  end

  # ステップ3: 給与振込
  def wizard_step3
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "給与振込", path: wizard_step3_admin_accounting_payroll_path(params[:id]) }
    ]

    @payroll_period = get_payroll_period(params[:id].to_i)

    # スタッフ別振込情報
    @staff_transfers = [
      {
        id: 1,
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        net_pay: 518_980,
        bank_name: "三菱UFJ銀行",
        branch_name: "新宿支店",
        account_type: "普通",
        account_number: "1234567",
        account_holder: "ヤマモト タロウ",
        transfer_status: "未振込"
      },
      {
        id: 2,
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        net_pay: 382_800,
        bank_name: "みずほ銀行",
        branch_name: "渋谷支店",
        account_type: "普通",
        account_number: "2345678",
        account_holder: "スズキ ハナコ",
        transfer_status: "未振込"
      },
      {
        id: 3,
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        net_pay: 325_248,
        bank_name: "三井住友銀行",
        branch_name: "池袋支店",
        account_type: "普通",
        account_number: "3456789",
        account_holder: "サトウ ミサキ",
        transfer_status: "未振込"
      },
      {
        id: 4,
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        net_pay: 439_296,
        bank_name: "りそな銀行",
        branch_name: "品川支店",
        account_type: "普通",
        account_number: "4567890",
        account_holder: "タカハシ ケンタ",
        transfer_status: "未振込"
      },
      {
        id: 5,
        staff_code: "ST-0006",
        staff_name: "伊藤里奈",
        net_pay: 224_576,
        bank_name: "ゆうちょ銀行",
        branch_name: "〇一八店",
        account_type: "普通",
        account_number: "5678901",
        account_holder: "イトウ リナ",
        transfer_status: "未振込"
      }
    ]

    @transfer_summary = {
      total_staff: @staff_transfers.count,
      total_amount: @staff_transfers.sum { |s| s[:net_pay] },
      transferred: 0,
      not_transferred: @staff_transfers.count,
      transfer_date: Date.today + 2.days
    }
  end

  def execute_step3
    # 実際の振込処理（モックなのでスキップ）
    flash[:success] = "給与振込が完了しました。"
    redirect_to wizard_step4_admin_accounting_payroll_path(params[:id])
  end

  # ステップ4: 完了
  def wizard_step4
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "経理管理", path: admin_accounting_payrolls_path },
      { name: "給与管理", path: admin_accounting_payrolls_path },
      { name: "給与計算完了", path: wizard_step4_admin_accounting_payroll_path(params[:id]) }
    ]

    @payroll_period = get_payroll_period(params[:id].to_i)

    # 完了サマリー
    @completion_summary = {
      period: @payroll_period[:period],
      total_staff: 170,
      working_staff: 150,
      non_working_staff: 20,
      total_work_hours: 1_191.5,
      total_gross_pay: 3_857_350,
      total_deductions: 402_080,
      total_net_pay: 3_455_270,
      calculation_completed_at: Time.current.strftime("%Y-%m-%d %H:%M"),
      slips_generated_at: Time.current.strftime("%Y-%m-%d %H:%M"),
      transfer_completed_at: Time.current.strftime("%Y-%m-%d %H:%M")
    }

    # エラー・警告
    @issues = [
      { type: "警告", message: "3名のスタッフの振込口座情報が未登録です", severity: "warning" },
      { type: "情報", message: "20名のスタッフは稼働実績がありませんでした", severity: "info" }
    ]
  end

  private

  def get_payroll_period(id)
    {
      id: id,
      period: "2025-12",
      period_start: "2025-12-01",
      period_end: "2025-12-31",
      staff_count: 170,
      total_amount: 55_200_000,
      status_calculate: "完了",
      status_generate_slips: "完了",
      status_transfer: "完了",
      created_by: "小林誠"
    }
  end

  def determine_current_step(payroll_period)
    return 4 if payroll_period[:status_transfer] == "完了"
    return 3 if payroll_period[:status_generate_slips] == "完了"
    return 2 if payroll_period[:status_calculate] == "完了"
    1
  end
end
