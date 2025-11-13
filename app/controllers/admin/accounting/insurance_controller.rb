class Admin::Accounting::InsuranceController < Admin::BaseController
  def index
    # サマリー情報
    @summary = {
      total_staff: 158,
      insured_staff: 142,
      uninsured_staff: 16,
      total_monthly_premium: 20_735_070,
      health_checkup_completed: 98,
      health_checkup_pending: 44
    }

    # スタッフ別社会保険加入状況
    @staff_insurance_list = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        age: 40,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "12345678",
        pension_number: "1234-567890",
        dependent_count: 2,
        monthly_premium_employee: 92_394,
        monthly_premium_company: 94_459,
        health_checkup_date: "2025-08-15",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0002",
        staff_name: "佐藤花子",
        age: 33,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "23456789",
        pension_number: "2345-678901",
        dependent_count: 0,
        monthly_premium_employee: 64_900,
        monthly_premium_company: 66_440,
        health_checkup_date: "2025-09-22",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0003",
        staff_name: "鈴木一郎",
        age: 37,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "34567890",
        pension_number: "3456-789012",
        dependent_count: 3,
        monthly_premium_employee: 78_175,
        monthly_premium_company: 80_030,
        health_checkup_date: "2025-07-10",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0008",
        staff_name: "田中美咲",
        age: 28,
        employment_type: "契約社員",
        insurance_status: "加入済",
        health_insurance_number: "45678901",
        pension_number: "4567-890123",
        dependent_count: 1,
        monthly_premium_employee: 58_320,
        monthly_premium_company: 59_680,
        health_checkup_date: nil,
        health_checkup_status: "未実施"
      },
      {
        staff_code: "ST-0015",
        staff_name: "伊藤健太",
        age: 24,
        employment_type: "契約社員",
        insurance_status: "加入済",
        health_insurance_number: "56789012",
        pension_number: "5678-901234",
        dependent_count: 0,
        monthly_premium_employee: 52_140,
        monthly_premium_company: 53_320,
        health_checkup_date: nil,
        health_checkup_status: "未実施"
      },
      {
        staff_code: "ST-0023",
        staff_name: "中村優子",
        age: 45,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "67890123",
        pension_number: "6789-012345",
        dependent_count: 2,
        monthly_premium_employee: 88_245,
        monthly_premium_company: 90_310,
        health_checkup_date: "2025-06-18",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0045",
        staff_name: "林優子",
        age: 31,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "78901234",
        pension_number: "7890-123456",
        dependent_count: 1,
        monthly_premium_employee: 69_720,
        monthly_premium_company: 71_280,
        health_checkup_date: "2025-10-05",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0067",
        staff_name: "森田誠",
        age: 29,
        employment_type: "契約社員",
        insurance_status: "加入済",
        health_insurance_number: "89012345",
        pension_number: "8901-234567",
        dependent_count: 0,
        monthly_premium_employee: 61_500,
        monthly_premium_company: 62_900,
        health_checkup_date: nil,
        health_checkup_status: "未実施"
      },
      {
        staff_code: "ST-0089",
        staff_name: "加藤隆",
        age: 36,
        employment_type: "正社員",
        insurance_status: "加入済",
        health_insurance_number: "90123456",
        pension_number: "9012-345678",
        dependent_count: 2,
        monthly_premium_employee: 75_620,
        monthly_premium_company: 77_380,
        health_checkup_date: "2025-09-14",
        health_checkup_status: "実施済"
      },
      {
        staff_code: "ST-0102",
        staff_name: "青木健",
        age: 22,
        employment_type: "アルバイト",
        insurance_status: "未加入",
        health_insurance_number: nil,
        pension_number: nil,
        dependent_count: 0,
        monthly_premium_employee: 0,
        monthly_premium_company: 0,
        health_checkup_date: nil,
        health_checkup_status: "対象外"
      }
    ]

    # 保険料推移データ
    @premium_trends = [
      { month: "2025-06", staff_count: 138, total_premium: 19_234_500 },
      { month: "2025-07", staff_count: 140, total_premium: 19_567_800 },
      { month: "2025-08", staff_count: 139, total_premium: 19_423_200 },
      { month: "2025-09", staff_count: 141, total_premium: 19_789_400 },
      { month: "2025-10", staff_count: 142, total_premium: 20_123_600 },
      { month: "2025-11", staff_count: 142, total_premium: 20_735_070 }
    ]

    # 健康診断実施状況
    @health_checkup_status = [
      { status: "実施済", count: 98, percentage: 69.0 },
      { status: "未実施", count: 44, percentage: 31.0 }
    ]

    # 保険証発行待ちリスト
    @pending_insurance_cards = [
      {
        staff_code: "ST-0156",
        staff_name: "渡辺直樹",
        application_date: "2025-11-01",
        expected_issue_date: "2025-11-25",
        days_elapsed: 12
      },
      {
        staff_code: "ST-0157",
        staff_name: "小林恵美",
        application_date: "2025-11-05",
        expected_issue_date: "2025-11-29",
        days_elapsed: 8
      }
    ]
  end
end
