class Admin::Staffing::ComplianceController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "手配管理", path: admin_staffing_compliance_index_path },
      { name: "コンプライアンス管理", path: admin_staffing_compliance_index_path }
    ]

    # KPIサマリー
    @summary = {
      total_staff: 158,
      compliant: 145,
      attention_required: 8,
      violation_risk: 5,
      cert_expiring: 8,
      audit_passed_rate: 96.8
    }

    # 派遣元台帳一覧
    @dispatch_ledgers = [
      {
        id: 1,
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        current_project: "A社システム開発",
        client_name: "A株式会社",
        dispatch_start: "2025-11-01",
        dispatch_end: "2026-03-31",
        contract_type: "特定派遣",
        work_location: "東京都港区",
        work_hours: "9:00-18:00",
        monthly_hours: 168.0,
        certification_status: "適合",
        health_check_date: "2025-06-15",
        health_check_next: "2026-06-15",
        status: "正常"
      },
      {
        id: 2,
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        current_project: "B社Webサイト構築",
        client_name: "B株式会社",
        dispatch_start: "2025-10-15",
        dispatch_end: "2026-02-28",
        contract_type: "一般派遣",
        work_location: "神奈川県横浜市",
        work_hours: "10:00-19:00",
        monthly_hours: 168.5,
        certification_status: "適合",
        health_check_date: "2025-08-20",
        health_check_next: "2026-08-20",
        status: "正常"
      },
      {
        id: 3,
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        current_project: nil,
        client_name: nil,
        dispatch_start: nil,
        dispatch_end: nil,
        contract_type: "特定派遣",
        work_location: nil,
        work_hours: nil,
        monthly_hours: 0,
        certification_status: "適合",
        health_check_date: "2025-07-10",
        health_check_next: "2026-07-10",
        status: "待機中"
      },
      {
        id: 4,
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        current_project: "C社業務システム開発",
        client_name: "C株式会社",
        dispatch_start: "2025-09-01",
        dispatch_end: "2026-08-31",
        contract_type: "特定派遣",
        work_location: "千葉県千葉市",
        work_hours: "9:30-18:30",
        monthly_hours: 165.0,
        certification_status: "要更新",
        health_check_date: "2024-11-30",
        health_check_next: "2025-11-30",
        status: "要確認"
      },
      {
        id: 5,
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        current_project: "D社インフラ構築",
        client_name: "D株式会社",
        dispatch_start: "2025-08-01",
        dispatch_end: "2026-07-31",
        contract_type: "特定派遣",
        work_location: "東京都新宿区",
        work_hours: "9:00-18:00",
        monthly_hours: 195.5,
        certification_status: "適合",
        health_check_date: "2025-05-15",
        health_check_next: "2026-05-15",
        status: "要注意"
      }
    ]

    # 36協定チェック（時間外労働）
    @labor_hours_check = [
      {
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        current_month_overtime: 35.5,
        limit_monthly: 36.0,
        remaining: 0.5,
        current_year_overtime: 280.5,
        limit_yearly: 360.0,
        risk_level: "高",
        status: "要注意"
      },
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        current_month_overtime: 28.5,
        limit_monthly: 36.0,
        remaining: 7.5,
        current_year_overtime: 245.0,
        limit_yearly: 360.0,
        risk_level: "中",
        status: "注意"
      },
      {
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        current_month_overtime: 15.5,
        limit_monthly: 36.0,
        remaining: 20.5,
        current_year_overtime: 158.0,
        limit_yearly: 360.0,
        risk_level: "低",
        status: "正常"
      },
      {
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        current_month_overtime: 18.0,
        limit_monthly: 36.0,
        remaining: 18.0,
        current_year_overtime: 175.5,
        limit_yearly: 360.0,
        risk_level: "低",
        status: "正常"
      },
      {
        staff_code: "ST-0007",
        staff_name: "渡辺翔太",
        current_month_overtime: 12.0,
        limit_monthly: 36.0,
        remaining: 24.0,
        current_year_overtime: 132.5,
        limit_yearly: 360.0,
        risk_level: "低",
        status: "正常"
      }
    ]

    # 資格・免許有効期限管理
    @certification_expiry = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        certification: "AWS SAA",
        expiry_date: "2025-12-15",
        days_remaining: 33,
        status: "要更新",
        renewal_progress: "未手配"
      },
      {
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        certification: "AWS SAP",
        expiry_date: "2025-12-20",
        days_remaining: 38,
        status: "要更新",
        renewal_progress: "申込済"
      },
      {
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        certification: "G検定",
        expiry_date: "2026-01-10",
        days_remaining: 59,
        status: "要更新",
        renewal_progress: "未手配"
      },
      {
        staff_code: "ST-0010",
        staff_name: "加藤大介",
        certification: "SAP Certified Application Associate",
        expiry_date: "2026-02-28",
        days_remaining: 108,
        status: "注意",
        renewal_progress: "未手配"
      },
      {
        staff_code: "ST-0012",
        staff_name: "吉田誠",
        certification: "PMP",
        expiry_date: "2026-03-15",
        days_remaining: 123,
        status: "注意",
        renewal_progress: "PDU取得中"
      }
    ]

    # コンプライアンス違反リスク
    @compliance_risks = [
      {
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        risk_type: "長時間労働",
        details: "月間残業時間が36時間協定上限に接近（35.5時間/36時間）",
        severity: "高",
        detected_at: "2025-11-11",
        action_required: "残業時間の削減指導"
      },
      {
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        risk_type: "健康診断期限",
        details: "健康診断の有効期限が19日後に到来",
        severity: "中",
        detected_at: "2025-11-10",
        action_required: "健康診断の受診手配"
      },
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        risk_type: "資格有効期限",
        details: "AWS SAA認定の有効期限が33日後",
        severity: "中",
        detected_at: "2025-11-08",
        action_required: "再認定試験の受験手配"
      },
      {
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        risk_type: "打刻漏れ",
        details: "11/11の出勤時刻が未入力",
        severity: "低",
        detected_at: "2025-11-11",
        action_required: "勤怠データの修正"
      }
    ]

    # 監査履歴
    @audit_logs = [
      {
        id: 1,
        audit_date: "2025-10-15",
        audit_type: "労働時間監査",
        auditor: "労務管理部",
        target_period: "2025年9月",
        result: "適合",
        findings_count: 0,
        remarks: "問題なし"
      },
      {
        id: 2,
        audit_date: "2025-09-20",
        audit_type: "派遣法定監査",
        auditor: "コンプライアンス部",
        target_period: "2025年8月",
        result: "要改善",
        findings_count: 2,
        remarks: "派遣元台帳の記載漏れ2件"
      },
      {
        id: 3,
        audit_date: "2025-08-10",
        audit_type: "健康診断実施状況監査",
        auditor: "安全衛生管理部",
        target_period: "2025年上半期",
        result: "適合",
        findings_count: 0,
        remarks: "受診率100%達成"
      },
      {
        id: 4,
        audit_date: "2025-07-05",
        audit_type: "36協定遵守監査",
        auditor: "労務管理部",
        target_period: "2025年上半期",
        result: "要注意",
        findings_count: 1,
        remarks: "1名が月間上限に接近"
      }
    ]

    # コンプライアンススコア推移
    @compliance_trends = [
      { month: "2025-06", score: 95.2, violations: 2, cert_expired: 1 },
      { month: "2025-07", score: 94.8, violations: 3, cert_expired: 2 },
      { month: "2025-08", score: 96.5, violations: 1, cert_expired: 1 },
      { month: "2025-09", score: 95.9, violations: 2, cert_expired: 1 },
      { month: "2025-10", score: 97.2, violations: 1, cert_expired: 0 },
      { month: "2025-11", score: 96.8, violations: 2, cert_expired: 2 }
    ]
  end
end
