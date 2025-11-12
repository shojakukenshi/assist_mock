import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "clientName", "projectName", "invoiceNumber",
                   "billingDate", "dueDate", "amount", "status", "paidDate", "paidAmount"]

  static values = {
    billing: Object
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
    const billingData = JSON.parse(row.dataset.billing)
    this.billingValue = billingData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const billing = this.billingValue

    this.clientNameTarget.textContent = billing.client_name
    this.projectNameTarget.textContent = billing.project_name
    this.invoiceNumberTarget.textContent = billing.invoice_number
    this.billingDateTarget.textContent = billing.billing_date
    this.dueDateTarget.textContent = billing.due_date
    this.amountTarget.textContent = `¥${billing.amount.toLocaleString()}`

    this.updateStatus(billing.status)

    this.paidDateTarget.textContent = billing.paid_date || '-'
    this.paidAmountTarget.textContent = billing.paid_amount ? `¥${billing.paid_amount.toLocaleString()}` : '-'
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '入金済':
        return 'bg-green-100 text-green-800'
      case '請求済':
        return 'bg-blue-100 text-blue-800'
      case '未請求':
        return 'bg-gray-100 text-gray-800'
      case '入金遅延':
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
