import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "name", "code", "age", "gender", "location",
                   "phone", "email", "status", "currentProject", "skillLevel",
                   "skills", "rating", "hourlyRate", "availabilityDate",
                   "workDays", "totalHours", "projectCount"]

  static values = {
    staff: Object
  }

  connect() {
    // ESCキーでパネルを閉じる
    this.escHandler = this.handleEsc.bind(this)
    document.addEventListener('keydown', this.escHandler)
  }

  disconnect() {
    document.removeEventListener('keydown', this.escHandler)
  }

  open(event) {
    const row = event.currentTarget
    const staffData = JSON.parse(row.dataset.staff)
    this.staffValue = staffData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const staff = this.staffValue

    // 基本情報
    this.nameTarget.textContent = staff.name
    this.codeTarget.textContent = staff.code
    this.ageTarget.textContent = `${staff.age}歳`
    this.genderTarget.textContent = staff.gender
    this.locationTarget.textContent = staff.location

    // 連絡先情報
    this.phoneTarget.textContent = staff.phone || '-'
    this.emailTarget.textContent = staff.email || '-'

    // ステータス
    this.updateStatus(staff.work_status)

    // 現在の案件
    this.currentProjectTarget.textContent = staff.current_project || '待機中'

    // スキルレベル
    this.updateSkillLevel(staff.skill_level)

    // スキル
    this.updateSkills(staff.skills)

    // 評価
    this.ratingTarget.textContent = staff.rating

    // 単価
    this.hourlyRateTarget.textContent = `¥${staff.hourly_rate.toLocaleString()}/h`

    // 稼働可能日
    this.availabilityDateTarget.textContent = staff.availability_date || '-'

    // 統計情報（サンプルデータ）
    this.workDaysTarget.textContent = staff.work_days || '20日'
    this.totalHoursTarget.textContent = staff.total_hours || '160h'
    this.projectCountTarget.textContent = staff.project_count || '5'
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '稼働中':
        return 'bg-green-100 text-green-800'
      case '待機中':
        return 'bg-yellow-100 text-yellow-800'
      case '休業中':
        return 'bg-gray-100 text-gray-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  updateSkillLevel(level) {
    const classes = this.getSkillLevelClasses(level)
    this.skillLevelTarget.className = `inline-flex px-2 py-1 text-xs font-semibold rounded-full ${classes}`
    this.skillLevelTarget.textContent = level
  }

  getSkillLevelClasses(level) {
    switch (level) {
      case '上級':
        return 'bg-purple-100 text-purple-800'
      case '中級':
        return 'bg-blue-100 text-blue-800'
      case '初級':
        return 'bg-gray-100 text-gray-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  updateSkills(skills) {
    this.skillsTarget.innerHTML = skills.map(skill =>
      `<span class="inline-flex px-3 py-1 text-sm rounded-full bg-blue-100 text-blue-800">${skill}</span>`
    ).join('')
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
