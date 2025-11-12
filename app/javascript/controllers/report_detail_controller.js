import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "reportType", "period", "submissionDate",
                   "status", "submitter", "dueDate", "description"]

  static values = {
    report: Object
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
    const reportData = JSON.parse(row.dataset.report)
    this.reportValue = reportData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const report = this.reportValue

    this.reportTypeTarget.textContent = report.report_type
    this.periodTarget.textContent = report.period
    this.submissionDateTarget.textContent = report.submission_date || '-'
    this.submitterTarget.textContent = report.submitter
    this.dueDateTarget.textContent = report.due_date
    this.descriptionTarget.textContent = report.description || '-'

    this.updateStatus(report.status)
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '提出済':
        return 'bg-green-100 text-green-800'
      case '作成中':
        return 'bg-blue-100 text-blue-800'
      case '未作成':
        return 'bg-gray-100 text-gray-800'
      case '遅延':
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
