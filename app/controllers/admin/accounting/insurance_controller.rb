class Admin::Accounting::InsuranceController < Admin::BaseController
  # トップページ - 給与計算履歴と処理ボタン
  def index
    # 給与計算履歴レコード（給与管理と同じデータ）
    @payroll_periods = [
      {
        id: 1,
        period: "2025-11",
        staff_count: 158,
        total_amount: 52_800_000,
        status_social_insurance: "完了",
        status_withholding_tax: "完了",
        social_insurance_completed_at: "2025-11-30 15:30",
        withholding_tax_completed_at: "2025-11-30 16:45"
      },
      {
        id: 2,
        period: "2025-10",
        staff_count: 162,
        total_amount: 54_200_000,
        status_social_insurance: "完了",
        status_withholding_tax: "完了",
        social_insurance_completed_at: "2025-10-31 14:20",
        withholding_tax_completed_at: "2025-10-31 15:30"
      },
      {
        id: 3,
        period: "2025-09",
        staff_count: 155,
        total_amount: 51_900_000,
        status_social_insurance: "完了",
        status_withholding_tax: "未実施",
        social_insurance_completed_at: "2025-09-30 16:00",
        withholding_tax_completed_at: nil
      },
      {
        id: 4,
        period: "2025-08",
        staff_count: 160,
        total_amount: 53_500_000,
        status_social_insurance: "未実施",
        status_withholding_tax: "未実施",
        social_insurance_completed_at: nil,
        withholding_tax_completed_at: nil
      }
    ]
  end

  # ========================================
  # 社会保険料計算フロー
  # ========================================

  # ステップ1: 標準報酬月額を確認
  def social_insurance_step1
    @period = params[:id]
    @staff_list = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        birth_date: "1985-03-15",
        age: 40,
        gross_pay: 589_750,
        standard_monthly_remuneration: 590_000,
        grade: 24,
        change_reason: nil
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        birth_date: "1992-07-22",
        age: 33,
        gross_pay: 445_200,
        standard_monthly_remuneration: 440_000,
        grade: 20,
        change_reason: nil
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        birth_date: "1988-11-08",
        age: 37,
        gross_pay: 523_600,
        standard_monthly_remuneration: 530_000,
        grade: 23,
        change_reason: nil
      },
      {
        staff_code: "ST-0005",
        staff_name: "高橋美咲",
        birth_date: "1995-02-14",
        age: 30,
        gross_pay: 378_000,
        standard_monthly_remuneration: 380_000,
        grade: 18,
        change_reason: nil
      },
      {
        staff_code: "ST-0012",
        staff_name: "中村健太",
        birth_date: "1983-09-30",
        age: 42,
        gross_pay: 612_400,
        standard_monthly_remuneration: 610_000,
        grade: 25,
        change_reason: nil
      }
    ]

    @summary = {
      total_staff: 158,
      staff_with_insurance: 158,
      average_standard_remuneration: 495_000
    }
  end

  def execute_social_insurance_step1
    redirect_to social_insurance_step2_admin_accounting_insurance_path(params[:id])
  end

  # ステップ2: 保険料率を適用
  def social_insurance_step2
    @period = params[:id]
    @insurance_rates = {
      health_insurance: {
        name: "健康保険",
        rate: 10.00,
        employee_rate: 5.00,
        company_rate: 5.00,
        type: "協会けんぽ（東京都）"
      },
      nursing_care: {
        name: "介護保険",
        rate: 1.82,
        employee_rate: 0.91,
        company_rate: 0.91,
        applicable_age: "40歳以上"
      },
      employees_pension: {
        name: "厚生年金保険",
        rate: 18.30,
        employee_rate: 9.15,
        company_rate: 9.15,
        type: "一般の被保険者"
      },
      employment_insurance: {
        name: "雇用保険",
        rate: 1.55,
        employee_rate: 0.60,
        company_rate: 0.95,
        type: "一般の事業"
      }
    }

    @staff_sample = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        age: 40,
        standard_monthly_remuneration: 590_000,
        applicable_rates: ["健康保険", "介護保険", "厚生年金保険", "雇用保険"]
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        age: 33,
        standard_monthly_remuneration: 440_000,
        applicable_rates: ["健康保険", "厚生年金保険", "雇用保険"]
      }
    ]
  end

  def execute_social_insurance_step2
    redirect_to social_insurance_step3_admin_accounting_insurance_path(params[:id])
  end

  # ステップ3: 従業員負担分と会社負担分を計算
  def social_insurance_step3
    @period = params[:id]
    @staff_calculations = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        age: 40,
        standard_monthly_remuneration: 590_000,
        health_insurance_employee: 29_500,
        health_insurance_company: 29_500,
        nursing_care_employee: 5_369,
        nursing_care_company: 5_369,
        employees_pension_employee: 53_985,
        employees_pension_company: 53_985,
        employment_insurance_employee: 3_540,
        employment_insurance_company: 5_605,
        total_employee_burden: 92_394,
        total_company_burden: 94_459,
        total_premium: 186_853
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        age: 33,
        standard_monthly_remuneration: 440_000,
        health_insurance_employee: 22_000,
        health_insurance_company: 22_000,
        nursing_care_employee: 0,
        nursing_care_company: 0,
        employees_pension_employee: 40_260,
        employees_pension_company: 40_260,
        employment_insurance_employee: 2_640,
        employment_insurance_company: 4_180,
        total_employee_burden: 64_900,
        total_company_burden: 66_440,
        total_premium: 131_340
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        age: 37,
        standard_monthly_remuneration: 530_000,
        health_insurance_employee: 26_500,
        health_insurance_company: 26_500,
        nursing_care_employee: 0,
        nursing_care_company: 0,
        employees_pension_employee: 48_495,
        employees_pension_company: 48_495,
        employment_insurance_employee: 3_180,
        employment_insurance_company: 5_035,
        total_employee_burden: 78_175,
        total_company_burden: 80_030,
        total_premium: 158_205
      }
    ]

    @summary = {
      total_staff: 158,
      total_employee_burden: 10_245_620,
      total_company_burden: 10_489_450,
      total_premium: 20_735_070
    }
  end

  def execute_social_insurance_step3
    redirect_to social_insurance_step4_admin_accounting_insurance_path(params[:id])
  end

  # ステップ4: 40歳以上は介護保険料を追加
  def social_insurance_step4
    @period = params[:id]
    @staff_over_40 = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        age: 40,
        standard_monthly_remuneration: 590_000,
        nursing_care_employee: 5_369,
        nursing_care_company: 5_369,
        nursing_care_total: 10_738,
        insurance_total_before: 176_115,
        insurance_total_after: 186_853
      },
      {
        staff_code: "ST-0012",
        staff_name: "中村健太",
        age: 42,
        standard_monthly_remuneration: 610_000,
        nursing_care_employee: 5_551,
        nursing_care_company: 5_551,
        nursing_care_total: 11_102,
        insurance_total_before: 182_155,
        insurance_total_after: 193_257
      },
      {
        staff_code: "ST-0018",
        staff_name: "伊藤敏子",
        age: 45,
        standard_monthly_remuneration: 480_000,
        nursing_care_employee: 4_368,
        nursing_care_company: 4_368,
        nursing_care_total: 8_736,
        insurance_total_before: 143_244,
        insurance_total_after: 151_980
      }
    ]

    @summary = {
      total_staff: 158,
      staff_over_40: 42,
      total_nursing_care_premium: 462_360,
      total_nursing_care_employee: 231_180,
      total_nursing_care_company: 231_180
    }
  end

  def execute_social_insurance_step4
    redirect_to social_insurance_step5_admin_accounting_insurance_path(params[:id])
  end

  # ステップ5: 月次保険料を確定
  def social_insurance_step5
    @period = params[:id]
    @monthly_premium_summary = {
      health_insurance_employee: 3_525_000,
      health_insurance_company: 3_525_000,
      health_insurance_total: 7_050_000,
      nursing_care_employee: 231_180,
      nursing_care_company: 231_180,
      nursing_care_total: 462_360,
      employees_pension_employee: 6_078_370,
      employees_pension_company: 6_078_370,
      employees_pension_total: 12_156_740,
      employment_insurance_employee: 411_070,
      employment_insurance_company: 654_900,
      employment_insurance_total: 1_065_970,
      grand_total_employee: 10_245_620,
      grand_total_company: 10_489_450,
      grand_total: 20_735_070
    }

    @payment_schedule = [
      {
        insurance_type: "健康保険・介護保険",
        payment_deadline: "2025-12-31",
        amount: 7_512_360,
        payment_destination: "全国健康保険協会（協会けんぽ）東京支部"
      },
      {
        insurance_type: "厚生年金保険",
        payment_deadline: "2025-12-31",
        amount: 12_156_740,
        payment_destination: "日本年金機構"
      },
      {
        insurance_type: "雇用保険",
        payment_deadline: "2025-12-31",
        amount: 1_065_970,
        payment_destination: "労働局"
      }
    ]

    @staff_deduction_list = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        gross_pay: 589_750,
        total_insurance_deduction: 92_394,
        net_pay_before_tax: 497_356
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        gross_pay: 445_200,
        total_insurance_deduction: 64_900,
        net_pay_before_tax: 380_300
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

  def execute_social_insurance_step5
    redirect_to social_insurance_step6_admin_accounting_insurance_path(params[:id])
  end

  # ステップ6: 変更があれば月額変更届を作成
  def social_insurance_step6
    @period = params[:id]
    @change_notifications = [
      {
        staff_code: "ST-0045",
        staff_name: "林優子",
        old_standard_remuneration: 320_000,
        new_standard_remuneration: 380_000,
        old_grade: 16,
        new_grade: 18,
        change_reason: "報酬の変動（3ヶ月連続で大幅変動）",
        change_date: "2025-12-01",
        notification_required: true,
        notification_type: "月額変更届",
        submission_deadline: "2025-12-31"
      },
      {
        staff_code: "ST-0089",
        staff_name: "森田誠",
        old_standard_remuneration: 440_000,
        new_standard_remuneration: 500_000,
        old_grade: 20,
        new_grade: 22,
        change_reason: "報酬の変動（昇給）",
        change_date: "2025-12-01",
        notification_required: true,
        notification_type: "月額変更届",
        submission_deadline: "2025-12-31"
      }
    ]

    @completion_summary = {
      period: "2025-11",
      total_staff: 158,
      total_premium: 20_735_070,
      company_burden: 10_489_450,
      change_notifications_count: 2,
      payment_deadline: "2025-12-31",
      completed_at: Time.current.strftime("%Y-%m-%d %H:%M")
    }
  end

  # ========================================
  # 源泉徴収処理フロー
  # ========================================

  # ステップ1: 課税対象額を算出
  def withholding_tax_step1
    @period = params[:id]
    @staff_list = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        gross_pay: 589_750,
        non_taxable_allowances: 10_000,
        social_insurance_deduction: 92_394,
        taxable_amount: 487_356
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        gross_pay: 445_200,
        non_taxable_allowances: 8_000,
        social_insurance_deduction: 64_900,
        taxable_amount: 372_300
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        gross_pay: 523_600,
        non_taxable_allowances: 9_500,
        social_insurance_deduction: 78_175,
        taxable_amount: 435_925
      },
      {
        staff_code: "ST-0005",
        staff_name: "高橋美咲",
        gross_pay: 378_000,
        non_taxable_allowances: 7_000,
        social_insurance_deduction: 55_230,
        taxable_amount: 315_770
      }
    ]

    @summary = {
      total_staff: 158,
      total_gross_pay: 52_800_000,
      total_non_taxable: 1_264_000,
      total_social_insurance: 10_245_620,
      total_taxable_amount: 41_290_380
    }
  end

  def execute_withholding_tax_step1
    redirect_to withholding_tax_step2_admin_accounting_insurance_path(params[:id])
  end

  # ステップ2: 扶養控除等申告書の内容を反映
  def withholding_tax_step2
    @period = params[:id]
    @staff_list = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        taxable_amount: 487_356,
        dependent_declaration_submitted: true,
        number_of_dependents: 2,
        spouse_deduction: true,
        dependent_type: "配偶者+扶養親族1人",
        tax_category: "甲欄"
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        taxable_amount: 372_300,
        dependent_declaration_submitted: true,
        number_of_dependents: 0,
        spouse_deduction: false,
        dependent_type: "扶養親族なし",
        tax_category: "甲欄"
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        taxable_amount: 435_925,
        dependent_declaration_submitted: true,
        number_of_dependents: 3,
        spouse_deduction: true,
        dependent_type: "配偶者+扶養親族2人",
        tax_category: "甲欄"
      },
      {
        staff_code: "ST-0078",
        staff_name: "青木健",
        taxable_amount: 256_800,
        dependent_declaration_submitted: false,
        number_of_dependents: 0,
        spouse_deduction: false,
        dependent_type: "未提出",
        tax_category: "乙欄"
      }
    ]

    @summary = {
      total_staff: 158,
      declaration_submitted: 155,
      declaration_not_submitted: 3,
      staff_with_dependents: 89,
      staff_without_dependents: 66
    }
  end

  def execute_withholding_tax_step2
    redirect_to withholding_tax_step3_admin_accounting_insurance_path(params[:id])
  end

  # ステップ3: 源泉徴収税額表を適用
  def withholding_tax_step3
    @period = params[:id]
    @tax_table_info = {
      applicable_table: "令和6年分 源泉徴収税額表（月額表）",
      effective_date: "2024-01-01",
      table_type: "給与所得の源泉徴収税額表（月額表）",
      tax_rate_structure: "超過累進税率"
    }

    @staff_sample = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        taxable_amount: 487_356,
        tax_category: "甲欄",
        dependent_count: 2,
        applicable_tax_bracket: "487,000円〜489,000円",
        tax_amount_before_adjustment: 12_540
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        taxable_amount: 372_300,
        tax_category: "甲欄",
        dependent_count: 0,
        applicable_tax_bracket: "372,000円〜374,000円",
        tax_amount_before_adjustment: 8_970
      }
    ]
  end

  def execute_withholding_tax_step3
    redirect_to withholding_tax_step4_admin_accounting_insurance_path(params[:id])
  end

  # ステップ4: 源泉所得税を計算
  def withholding_tax_step4
    @period = params[:id]
    @staff_calculations = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        gross_pay: 589_750,
        social_insurance_deduction: 92_394,
        taxable_amount: 487_356,
        withholding_tax: 12_540,
        net_pay: 484_816
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        gross_pay: 445_200,
        social_insurance_deduction: 64_900,
        taxable_amount: 372_300,
        withholding_tax: 8_970,
        net_pay: 371_330
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        gross_pay: 523_600,
        social_insurance_deduction: 78_175,
        taxable_amount: 435_925,
        withholding_tax: 9_820,
        net_pay: 435_605
      },
      {
        staff_code: "ST-0005",
        staff_name: "高橋美咲",
        gross_pay: 378_000,
        social_insurance_deduction: 55_230,
        taxable_amount: 315_770,
        withholding_tax: 6_540,
        net_pay: 316_230
      }
    ]

    @summary = {
      total_staff: 158,
      total_gross_pay: 52_800_000,
      total_social_insurance: 10_245_620,
      total_taxable_amount: 41_290_380,
      total_withholding_tax: 1_652_400,
      total_net_pay: 40_901_980
    }
  end

  def execute_withholding_tax_step4
    redirect_to withholding_tax_step5_admin_accounting_insurance_path(params[:id])
  end

  # ステップ5: 納付書を作成
  def withholding_tax_step5
    @period = params[:id]
    @payment_slip = {
      slip_number: "2025-11-001",
      tax_period: "2025年11月分",
      payment_deadline: "2025-12-10",
      total_amount: 1_652_400,
      number_of_employees: 158,
      company_name: "株式会社イベントスタッフサービス",
      company_address: "東京都港区六本木1-1-1",
      tax_office: "麻布税務署",
      payment_method: "電子納税（e-Tax）"
    }

    @monthly_breakdown = {
      employee_count: 158,
      total_withholding_tax: 1_652_400,
      tax_category_breakdown: {
        kou_column: {
          name: "甲欄適用者",
          count: 155,
          amount: 1_612_900
        },
        otsu_column: {
          name: "乙欄適用者",
          count: 3,
          amount: 39_500
        }
      }
    }

    @payment_history = [
      { month: "2025-10", amount: 1_584_200, paid_date: "2025-11-08", status: "納付済" },
      { month: "2025-09", amount: 1_598_800, paid_date: "2025-10-09", status: "納付済" },
      { month: "2025-08", amount: 1_623_500, paid_date: "2025-09-10", status: "納付済" }
    ]
  end

  def execute_withholding_tax_step5
    redirect_to withholding_tax_step6_admin_accounting_insurance_path(params[:id])
  end

  # ステップ6: 年末調整で精算
  def withholding_tax_step6
    @period = params[:id]
    @year_end_adjustment_info = {
      description: "年末調整は12月の給与計算時に実施されます。",
      adjustment_items: [
        "生命保険料控除",
        "地震保険料控除",
        "社会保険料控除（国民年金等）",
        "小規模企業共済等掛金控除",
        "住宅借入金等特別控除"
      ],
      required_documents: [
        "給与所得者の保険料控除申告書",
        "給与所得者の基礎控除申告書 兼 配偶者控除等申告書 兼 所得金額調整控除申告書",
        "住宅借入金等特別控除申告書（該当者のみ）",
        "保険料控除証明書",
        "住宅ローン残高証明書（該当者のみ）"
      ]
    }

    @completion_summary = {
      period: "2025-11",
      total_staff: 158,
      total_withholding_tax: 1_652_400,
      payment_deadline: "2025-12-10",
      payment_slip_number: "2025-11-001",
      completed_at: Time.current.strftime("%Y-%m-%d %H:%M")
    }
  end
end
