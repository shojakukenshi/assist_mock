import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "staffName", "staffCode", "checkType", "checkDate",
                   "status", "checker", "findings", "nextCheckDate"]

  static values = {
    compliance: Object
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
    const complianceData = JSON.parse(row.dataset.compliance)
    this.complianceValue = complianceData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const compliance = this.complianceValue

    this.staffNameTarget.textContent = compliance.staff_name
    this.staffCodeTarget.textContent = compliance.staff_code
    this.checkTypeTarget.textContent = compliance.check_type
    this.checkDateTarget.textContent = compliance.check_date
    this.checkerTarget.textContent = compliance.checker
    this.findingsTarget.textContent = compliance.findings || 'なし'
    this.nextCheckDateTarget.textContent = compliance.next_check_date

    this.updateStatus(compliance.status)
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '合格':
        return 'bg-green-100 text-green-800'
      case '要改善':
        return 'bg-yellow-100 text-yellow-800'
      case '不合格':
        return 'bg-red-100 text-red-800'
      case '未実施':
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
