class Admin::Staffing::AttendancesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "手配管理", path: admin_staffing_attendances_path },
      { name: "勤怠管理", path: admin_staffing_attendances_path }
    ]

    # KPIサマリー
    @summary = {
      total_records: 342,
      pending_approval: 28,
      approved_this_month: 285,
      anomaly_detected: 5,
      total_hours: 54720,
      avg_hours_per_staff: 168.5
    }

    # 勤怠一覧
    @attendances = [
      {
        id: 1,
        date: "2025-11-11",
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        project_name: "A社システム開発",
        work_type: "通常勤務",
        start_time: "09:00",
        end_time: "18:00",
        break_minutes: 60,
        work_hours: 8.0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "承認済",
        approved_by: "田中部長",
        approved_at: "2025-11-12 10:00",
        remarks: nil,
        anomaly: nil
      },
      {
        id: 2,
        date: "2025-11-11",
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        project_name: "B社Webサイト構築",
        work_type: "通常勤務",
        start_time: "10:00",
        end_time: "19:30",
        break_minutes: 60,
        work_hours: 8.5,
        overtime_hours: 0.5,
        holiday_hours: 0,
        status: "承認済",
        approved_by: "田中部長",
        approved_at: "2025-11-12 10:05",
        remarks: "客先対応により30分延長",
        anomaly: nil
      },
      {
        id: 3,
        date: "2025-11-11",
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        project_name: nil,
        work_type: "待機",
        start_time: nil,
        end_time: nil,
        break_minutes: 0,
        work_hours: 0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "承認済",
        approved_by: "自動承認",
        approved_at: "2025-11-12 00:00",
        remarks: "待機期間",
        anomaly: nil
      },
      {
        id: 4,
        date: "2025-11-11",
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        project_name: "C社業務システム開発",
        work_type: "通常勤務",
        start_time: "09:30",
        end_time: "18:30",
        break_minutes: 60,
        work_hours: 8.0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "未承認",
        approved_by: nil,
        approved_at: nil,
        remarks: nil,
        anomaly: nil
      },
      {
        id: 5,
        date: "2025-11-11",
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        project_name: "D社インフラ構築",
        work_type: "通常勤務",
        start_time: "09:00",
        end_time: "22:00",
        break_minutes: 90,
        work_hours: 11.5,
        overtime_hours: 3.5,
        holiday_hours: 0,
        status: "未承認",
        approved_by: nil,
        approved_at: nil,
        remarks: "障害対応のため残業",
        anomaly: "長時間残業"
      },
      {
        id: 6,
        date: "2025-11-10",
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        project_name: "A社システム開発",
        work_type: "休日出勤",
        start_time: "10:00",
        end_time: "16:00",
        break_minutes: 60,
        work_hours: 5.0,
        overtime_hours: 0,
        holiday_hours: 5.0,
        status: "未承認",
        approved_by: nil,
        approved_at: nil,
        remarks: "緊急対応のため休日出勤",
        anomaly: "休日出勤"
      },
      {
        id: 7,
        date: "2025-11-11",
        staff_code: "ST-0007",
        staff_name: "渡辺翔太",
        project_name: "E社ECサイト開発",
        work_type: "通常勤務",
        start_time: "09:00",
        end_time: "18:00",
        break_minutes: 60,
        work_hours: 8.0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "未承認",
        approved_by: nil,
        approved_at: nil,
        remarks: nil,
        anomaly: nil
      },
      {
        id: 8,
        date: "2025-11-11",
        staff_code: "ST-0010",
        staff_name: "加藤大介",
        project_name: "F社基幹システム刷新",
        work_type: "通常勤務",
        start_time: "08:30",
        end_time: "17:30",
        break_minutes: 60,
        work_hours: 8.0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "承認済",
        approved_by: "田中部長",
        approved_at: "2025-11-12 09:30",
        remarks: nil,
        anomaly: nil
      },
      {
        id: 9,
        date: "2025-11-11",
        staff_code: "ST-0011",
        staff_name: "松本愛",
        project_name: "G社モバイルアプリ開発",
        work_type: "リモート勤務",
        start_time: "10:00",
        end_time: "19:00",
        break_minutes: 60,
        work_hours: 8.0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "未承認",
        approved_by: nil,
        approved_at: nil,
        remarks: "在宅勤務",
        anomaly: nil
      },
      {
        id: 10,
        date: "2025-11-11",
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        project_name: "B社Webサイト構築",
        work_type: "通常勤務",
        start_time: nil,
        end_time: "19:00",
        break_minutes: 60,
        work_hours: 0,
        overtime_hours: 0,
        holiday_hours: 0,
        status: "差戻し",
        approved_by: "田中部長",
        approved_at: nil,
        remarks: "出勤時刻が未入力です。修正してください。",
        anomaly: "打刻漏れ"
      }
    ]

    # 月次勤怠集計（スタッフ別）
    @monthly_summary = [
      {
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        work_days: 20,
        total_hours: 168.0,
        overtime_hours: 8.5,
        holiday_hours: 5.0,
        absence_days: 0,
        late_count: 0,
        status: "正常"
      },
      {
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        work_days: 19,
        total_hours: 158.5,
        overtime_hours: 5.5,
        holiday_hours: 0,
        absence_days: 1,
        late_count: 1,
        status: "要確認"
      },
      {
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        work_days: 0,
        total_hours: 0,
        overtime_hours: 0,
        holiday_hours: 0,
        absence_days: 0,
        late_count: 0,
        status: "待機中"
      },
      {
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        work_days: 20,
        total_hours: 165.0,
        overtime_hours: 5.0,
        holiday_hours: 0,
        absence_days: 0,
        late_count: 0,
        status: "正常"
      },
      {
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        work_days: 22,
        total_hours: 195.5,
        overtime_hours: 35.5,
        holiday_hours: 8.0,
        absence_days: 0,
        late_count: 0,
        status: "要注意"
      }
    ]

    # 異常検知アラート
    @anomaly_alerts = [
      {
        staff_name: "高橋健太",
        alert_type: "長時間残業",
        details: "月間残業時間が35.5時間（上限36時間に接近）",
        severity: "高"
      },
      {
        staff_name: "山本太郎",
        alert_type: "休日出勤",
        details: "11/10（日）に休日出勤5時間",
        severity: "中"
      },
      {
        staff_name: "鈴木花子",
        alert_type: "打刻漏れ",
        details: "11/11の出勤時刻が未入力",
        severity: "中"
      },
      {
        staff_name: "佐藤美咲",
        alert_type: "遅刻",
        details: "11/08に30分遅刻",
        severity: "低"
      }
    ]

    # 勤怠集計推移（月次）
    @attendance_trends = [
      { month: "2025-06", total_hours: 52000, overtime_hours: 1800, holiday_hours: 320 },
      { month: "2025-07", total_hours: 53500, overtime_hours: 2100, holiday_hours: 280 },
      { month: "2025-08", total_hours: 51800, overtime_hours: 1650, holiday_hours: 240 },
      { month: "2025-09", total_hours: 54200, overtime_hours: 2300, holiday_hours: 360 },
      { month: "2025-10", total_hours: 55100, overtime_hours: 2450, holiday_hours: 400 },
      { month: "2025-11", total_hours: 54720, overtime_hours: 2280, holiday_hours: 380 }
    ]
  end
end
