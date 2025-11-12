import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "date", "staffName", "staffCode", "projectName",
                   "workType", "startTime", "endTime", "workHours", "overtimeHours",
                   "status", "anomaly"]

  static values = {
    attendance: Object
  }

  connect() {
    this.escHandler = this.handleEsc.bind(this)
    document.addEventListener('keydown', this.escHandler)
  }

  disconnect() {
    document.removeEventListener('keydown', this.escHandler)
  }

  open(event) {
    const row = event.currentTarget
    const attendanceData = JSON.parse(row.dataset.attendance)
    this.attendanceValue = attendanceData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const attendance = this.attendanceValue

    // 基本情報
    this.dateTarget.textContent = attendance.date
    this.staffNameTarget.textContent = attendance.staff_name
    this.staffCodeTarget.textContent = attendance.staff_code
    this.projectNameTarget.textContent = attendance.project_name || '-'

    // 勤務形態
    this.updateWorkType(attendance.work_type)

    // 時刻
    this.startTimeTarget.textContent = attendance.start_time || '-'
    this.endTimeTarget.textContent = attendance.end_time || '-'

    // 労働時間
    this.workHoursTarget.textContent = `${attendance.work_hours}h`

    // 残業時間
    if (attendance.overtime_hours > 0) {
      const overtimeClass = attendance.overtime_hours > 3 ? 'text-red-600 font-bold' : 'text-orange-600'
      this.overtimeHoursTarget.className = `text-2xl font-bold ${overtimeClass}`
      this.overtimeHoursTarget.textContent = `${attendance.overtime_hours}h`
    } else {
      this.overtimeHoursTarget.className = 'text-2xl font-bold text-gray-400'
      this.overtimeHoursTarget.textContent = '0h'
    }

    // ステータス
    this.updateStatus(attendance.status)

    // 異常検知
    if (attendance.anomaly) {
      this.anomalyTarget.classList.remove('hidden')
      this.anomalyTarget.textContent = attendance.anomaly
    } else {
      this.anomalyTarget.classList.add('hidden')
    }
  }

  updateWorkType(workType) {
    const classes = this.getWorkTypeClasses(workType)
    this.workTypeTarget.className = `inline-flex px-2 py-1 text-xs font-medium rounded-full ${classes}`
    this.workTypeTarget.textContent = workType
  }

  getWorkTypeClasses(workType) {
    switch (workType) {
      case '通常勤務':
        return 'bg-blue-100 text-blue-800'
      case 'リモート勤務':
        return 'bg-purple-100 text-purple-800'
      case '休日出勤':
        return 'bg-orange-100 text-orange-800'
      case '待機':
        return 'bg-gray-100 text-gray-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '承認済':
        return 'bg-green-100 text-green-800'
      case '未承認':
        return 'bg-yellow-100 text-yellow-800'
      case '差戻し':
        return 'bg-red-100 text-red-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  showPanel() {
    this.panelTarget.classList.remove('translate-x-full')
  }

  closePanel() {
    this.panelTarget.classList.add('translate-x-full')
  }

  handleEsc(event) {
    if (event.key === 'Escape') {
      this.closePanel()
    }
  }
}
