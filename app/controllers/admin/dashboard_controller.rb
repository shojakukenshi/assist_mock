module Admin
  class DashboardController < BaseController
    def index
      add_breadcrumb "ダッシュボード"

      # 部門選択（デフォルトは営業）
      @current_department = params[:department] || "sales"

      case @current_department
      when "sales"
        setup_sales_dashboard
      when "staffing"
        setup_staffing_dashboard
      when "accounting"
        setup_accounting_dashboard
      else
        setup_sales_dashboard
      end
    end

    private

    # 営業部門ダッシュボード
    def setup_sales_dashboard
      # KPIサマリー（パイプラインページと同じ形式）
      @project_summary = {
        total_deals: 10,
        total_value: 31_800_000,
        expected_revenue: 24_300_000,
        success_rate: 85.0,
        average_lead_time: 18 # 日数
      }

      # 近日中のアクションリスト
      @action_list = [
        {
          type: "proposal",
          title: "【提案】イベントスタッフ派遣案件",
          client: "株式会社イベントプランニング",
          deadline: "2025-11-15",
          priority: "high",
          status: "対応中"
        },
        {
          type: "contract",
          title: "【契約更新】システム保守案件",
          client: "○○システムズ",
          deadline: "2025-11-18",
          priority: "high",
          status: "未着手"
        },
        {
          type: "meeting",
          title: "【商談】新規クライアント打ち合わせ",
          client: "△△商事株式会社",
          deadline: "2025-11-16",
          priority: "medium",
          status: "予定"
        },
        {
          type: "follow_up",
          title: "【フォロー】見積提出後の確認",
          client: "株式会社サンプル",
          deadline: "2025-11-17",
          priority: "medium",
          status: "未着手"
        }
      ]

      # 月次目標達成率（月別推移）
      @monthly_achievement = [
        { month: "6月", target: 5500, actual: 4850, rate: 88.2 },
        { month: "7月", target: 5800, actual: 5230, rate: 90.2 },
        { month: "8月", target: 6000, actual: 5680, rate: 94.7 },
        { month: "9月", target: 6000, actual: 5120, rate: 85.3 },
        { month: "10月", target: 6200, actual: 5890, rate: 95.0 },
        { month: "11月", target: 6000, actual: 5280, rate: 88.0 }
      ]

      # 経費登録通知
      @expense_notifications = [
        { staff_name: "山本太郎", project: "イベントスタッフ派遣", amount: 12_500, date: "2025-11-12", status: "未承認" },
        { staff_name: "佐藤花子", project: "システム保守案件", amount: 8_300, date: "2025-11-11", status: "未承認" },
        { staff_name: "鈴木一郎", project: "データ入力業務", amount: 15_600, date: "2025-11-10", status: "未承認" }
      ]

      # 入金遅延アラート
      @payment_delay_alerts = [
        {
          client: "株式会社サンプル",
          invoice_number: "INV-2025-10-001",
          amount: 2_850_000,
          due_date: "2025-10-31",
          delay_days: 13,
          status: "未入金"
        },
        {
          client: "○○商事株式会社",
          invoice_number: "INV-2025-10-015",
          amount: 1_250_000,
          due_date: "2025-11-05",
          delay_days: 8,
          status: "未入金"
        },
        {
          client: "△△システムズ",
          invoice_number: "INV-2025-10-022",
          amount: 980_000,
          due_date: "2025-11-10",
          delay_days: 3,
          status: "一部入金"
        }
      ]
    end

    # 手配部門ダッシュボード
    def setup_staffing_dashboard
      # 稼働状況サマリー
      @staffing_summary = {
        total_staff: 245,
        active_staff: 158,
        available_staff: 62,
        on_leave: 25,
        utilization_rate: 64.5,
        new_applications: 8,
        pending_assignments: 12
      }

      # 月次稼働状況の推移
      @monthly_utilization = [
        { month: "6月", total: 238, active: 145, rate: 60.9 },
        { month: "7月", total: 240, active: 152, rate: 63.3 },
        { month: "8月", total: 242, active: 160, rate: 66.1 },
        { month: "9月", total: 243, active: 155, rate: 63.8 },
        { month: "10月", total: 244, active: 162, rate: 66.4 },
        { month: "11月", total: 245, active: 158, rate: 64.5 }
      ]

      # 資格有効期限アラート
      @qualification_alerts = [
        { staff_code: "ST-0045", staff_name: "林優子", qualification: "フォークリフト運転技能講習", expiry_date: "2025-11-20", days_remaining: 7 },
        { staff_code: "ST-0089", staff_name: "森田誠", qualification: "衛生管理者", expiry_date: "2025-11-25", days_remaining: 12 },
        { staff_code: "ST-0123", staff_name: "井上美咲", qualification: "危険物取扱者", expiry_date: "2025-12-05", days_remaining: 22 },
        { staff_code: "ST-0156", staff_name: "小林健太", qualification: "特定化学物質作業主任者", expiry_date: "2025-11-18", days_remaining: 5 }
      ]

      # スタッフ応募通知
      @staff_application_notifications = [
        {
          application_date: "2025-11-13 09:30",
          staff_name: "新規登録：田中一郎",
          desired_positions: ["イベントスタッフ", "倉庫作業"],
          experience_years: 3,
          status: "書類確認待ち"
        },
        {
          application_date: "2025-11-12 14:20",
          staff_name: "新規登録：山田花子",
          desired_positions: ["事務補助", "データ入力"],
          experience_years: 5,
          status: "書類確認待ち"
        },
        {
          application_date: "2025-11-12 11:45",
          staff_name: "再登録：鈴木次郎",
          desired_positions: ["システムサポート"],
          experience_years: 7,
          status: "面接調整中"
        }
      ]

      # 要手配案件アラート
      @assignment_required_alerts = [
        {
          project_name: "イベントスタッフ派遣（東京ドーム）",
          client: "株式会社イベントプランニング",
          required_staff: 15,
          assigned_staff: 8,
          shortage: 7,
          event_date: "2025-11-22",
          days_until_event: 9,
          urgency: "high"
        },
        {
          project_name: "倉庫内軽作業（千葉物流センター）",
          client: "○○ロジスティクス",
          required_staff: 10,
          assigned_staff: 7,
          shortage: 3,
          event_date: "2025-11-18",
          days_until_event: 5,
          urgency: "high"
        },
        {
          project_name: "データ入力業務（本社）",
          client: "△△システムズ",
          required_staff: 5,
          assigned_staff: 3,
          shortage: 2,
          event_date: "2025-11-25",
          days_until_event: 12,
          urgency: "medium"
        }
      ]

      # 勤怠異常アラート
      @attendance_alerts = [
        { staff_code: "ST-0078", staff_name: "青木健", issue: "3日連続遅刻", date: "2025-11-13", severity: "warning" },
        { staff_code: "ST-0145", staff_name: "渡辺真理", issue: "打刻漏れ", date: "2025-11-12", severity: "info" },
        { staff_code: "ST-0198", staff_name: "中村陽子", issue: "残業時間超過（45時間）", date: "2025-11-11", severity: "warning" },
        { staff_code: "ST-0234", staff_name: "加藤大輔", issue: "無断欠勤", date: "2025-11-10", severity: "critical" }
      ]

      # サポート通知
      @support_notifications = [
        { date: "2025-11-13 10:15", staff: "ST-0089 森田誠", type: "問い合わせ", content: "給与明細の確認方法について", status: "対応中" },
        { date: "2025-11-12 16:30", staff: "ST-0123 井上美咲", type: "トラブル報告", content: "現場での機材不具合", status: "解決済" },
        { date: "2025-11-12 09:00", staff: "ST-0045 林優子", type: "シフト変更依頼", content: "11/20のシフト変更希望", status: "承認待ち" }
      ]
    end

    # 経理部門ダッシュボード
    def setup_accounting_dashboard
      # 月次会計処理スケジュール
      @accounting_schedule = [
        { date: "2025-11-15", task: "給与計算開始", category: "payroll", status: "予定", priority: "high" },
        { date: "2025-11-20", task: "給与明細発行", category: "payroll", status: "予定", priority: "high" },
        { date: "2025-11-25", task: "給与振込", category: "payroll", status: "予定", priority: "critical" },
        { date: "2025-11-30", task: "月次決算", category: "closing", status: "予定", priority: "high" },
        { date: "2025-12-10", task: "源泉徴収税納付", category: "tax", status: "予定", priority: "critical" },
        { date: "2025-12-15", task: "売掛金回収確認", category: "receivable", status: "予定", priority: "medium" },
        { date: "2025-12-20", task: "買掛金支払", category: "payable", status: "予定", priority: "high" },
        { date: "2025-12-31", task: "社会保険料納付", category: "insurance", status: "予定", priority: "critical" }
      ]

      # 今月のカレンダーイベント（簡易版）
      @calendar_events = generate_calendar_events

      # 異常アラート
      @anomaly_alerts = [
        {
          type: "勤怠データ不整合",
          description: "スタッフST-0145の勤怠データに打刻漏れ",
          affected_period: "2025-11-12",
          severity: "warning",
          action_required: "勤怠修正が必要"
        },
        {
          type: "経費精算遅延",
          description: "10月分の経費精算が未完了（3件）",
          affected_period: "2025-10",
          severity: "warning",
          action_required: "経費精算処理を完了してください"
        },
        {
          type: "請求書金額相違",
          description: "請求書INV-2025-11-008の金額が契約金額と不一致",
          affected_period: "2025-11-08",
          severity: "critical",
          action_required: "請求書を確認・修正してください"
        },
        {
          type: "支払予定超過",
          description: "今月の支払予定額が予算を15%超過",
          affected_period: "2025-11",
          severity: "info",
          action_required: "予算管理の確認が必要"
        }
      ]

      # 提出期限アラート
      @deadline_alerts = [
        {
          document: "源泉徴収税納付書",
          deadline: "2025-12-10",
          days_remaining: 27,
          status: "未作成",
          responsible: "経理部",
          priority: "high"
        },
        {
          document: "社会保険料納付書",
          deadline: "2025-12-31",
          days_remaining: 48,
          status: "未作成",
          responsible: "経理部",
          priority: "high"
        },
        {
          document: "給与支払報告書",
          deadline: "2026-01-31",
          days_remaining: 79,
          status: "準備中",
          responsible: "経理部",
          priority: "medium"
        },
        {
          document: "法定調書合計表",
          deadline: "2026-01-31",
          days_remaining: 79,
          status: "未着手",
          responsible: "経理部",
          priority: "medium"
        }
      ]

      # 会計処理トピックス
      @accounting_topics = [
        {
          date: "2025-11-13",
          title: "給与計算期間2025-11の処理状況",
          description: "社会保険料計算・源泉徴収処理ともに完了しました。給与明細発行の準備が整っています。",
          category: "完了報告",
          importance: "info"
        },
        {
          date: "2025-11-12",
          title: "入金遅延案件のフォローアップ",
          description: "株式会社サンプル（INV-2025-10-001）について、13日間の入金遅延が発生しています。営業部門と連携して催促を実施中。",
          category: "要対応",
          importance: "warning"
        },
        {
          date: "2025-11-11",
          title: "年末調整書類の回収状況",
          description: "年末調整に必要な書類の回収率は68%（155/228名提出済）。未提出者への再案内を実施予定。",
          category: "進捗報告",
          importance: "info"
        },
        {
          date: "2025-11-10",
          title: "消費税申告の準備開始",
          description: "第3四半期の消費税申告に向けて、取引データの整合性確認を開始しました。",
          category: "開始報告",
          importance: "info"
        }
      ]

      # 月次処理進捗サマリー
      @monthly_processing_summary = {
        payroll_calculation: { status: "完了", completion_rate: 100, due_date: "2025-11-15" },
        payslip_issuance: { status: "未着手", completion_rate: 0, due_date: "2025-11-20" },
        payment_transfer: { status: "未着手", completion_rate: 0, due_date: "2025-11-25" },
        monthly_closing: { status: "未着手", completion_rate: 0, due_date: "2025-11-30" },
        tax_filing: { status: "準備中", completion_rate: 35, due_date: "2025-12-10" },
        insurance_payment: { status: "準備中", completion_rate: 45, due_date: "2025-12-31" }
      }
    end

    # カレンダーイベント生成（簡易版）
    def generate_calendar_events
      events = {}

      # 11月のスケジュール
      events["2025-11-15"] = [{ task: "給与計算開始", category: "payroll" }]
      events["2025-11-20"] = [{ task: "給与明細発行", category: "payroll" }]
      events["2025-11-25"] = [{ task: "給与振込", category: "payroll" }]
      events["2025-11-30"] = [{ task: "月次決算", category: "closing" }]

      # 12月のスケジュール
      events["2025-12-10"] = [{ task: "源泉徴収税納付", category: "tax" }]
      events["2025-12-15"] = [{ task: "売掛金回収確認", category: "receivable" }]
      events["2025-12-20"] = [{ task: "買掛金支払", category: "payable" }]
      events["2025-12-31"] = [{ task: "社会保険料納付", category: "insurance" }]

      events
    end
  end
end
