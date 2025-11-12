import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "projectName", "clientName", "location",
                   "requiredSkills", "skillLevel", "startDate", "endDate",
                   "assignedCount", "requiredCount", "hourlyBudget",
                   "priority", "deadline"]

  static values = {
    project: Object
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
    const projectData = JSON.parse(row.dataset.project)
    this.projectValue = projectData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const project = this.projectValue

    // 基本情報
    this.projectNameTarget.textContent = project.project_name
    this.clientNameTarget.textContent = project.client_name
    this.locationTarget.textContent = project.location

    // 必須スキル
    this.updateRequiredSkills(project.required_skills)

    // スキルレベル
    this.skillLevelTarget.textContent = project.skill_level

    // 期間
    this.startDateTarget.textContent = project.start_date
    this.endDateTarget.textContent = project.end_date

    // 募集/配置
    this.assignedCountTarget.textContent = project.assigned_count
    this.requiredCountTarget.textContent = project.required_count

    // 予算
    this.hourlyBudgetTarget.textContent = `¥${project.hourly_budget.toLocaleString()}/h`

    // 優先度
    this.updatePriority(project.priority)

    // 期限
    this.deadlineTarget.textContent = project.deadline
  }

  updateRequiredSkills(skills) {
    this.requiredSkillsTarget.innerHTML = skills.map(skill =>
      `<span class="inline-flex px-3 py-1 text-sm rounded-full bg-blue-100 text-blue-800">${skill}</span>`
    ).join('')
  }

  updatePriority(priority) {
    const classes = this.getPriorityClasses(priority)
    this.priorityTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.priorityTarget.textContent = priority
  }

  getPriorityClasses(priority) {
    switch (priority) {
      case '高':
        return 'bg-red-100 text-red-800'
      case '中':
        return 'bg-yellow-100 text-yellow-800'
      case '低':
        return 'bg-gray-100 text-gray-800'
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
