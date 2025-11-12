import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "staffName", "staffCode", "category", "status",
                   "priority", "title", "description", "createdDate", "assignedTo", "updatedDate"]

  static values = {
    support: Object
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
    const supportData = JSON.parse(row.dataset.support)
    this.supportValue = supportData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const support = this.supportValue

    this.staffNameTarget.textContent = support.staff_name
    this.staffCodeTarget.textContent = support.staff_code
    this.categoryTarget.textContent = support.category
    this.titleTarget.textContent = support.title
    this.descriptionTarget.textContent = support.description
    this.createdDateTarget.textContent = support.created_date
    this.assignedToTarget.textContent = support.assigned_to
    this.updatedDateTarget.textContent = support.updated_date

    this.updateStatus(support.status)
    this.updatePriority(support.priority)
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '対応完了':
        return 'bg-green-100 text-green-800'
      case '対応中':
        return 'bg-blue-100 text-blue-800'
      case '新規':
        return 'bg-yellow-100 text-yellow-800'
      case '保留':
        return 'bg-gray-100 text-gray-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  updatePriority(priority) {
    const classes = this.getPriorityClasses(priority)
    this.priorityTarget.className = `inline-flex px-2 py-1 text-xs font-semibold rounded-full ${classes}`
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
