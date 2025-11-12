import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "clientName", "projectName", "invoiceNumber",
                   "billingDate", "dueDate", "amount", "paidAmount", "balance", "status"]

  static values = {
    receivable: Object
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
    const receivableData = JSON.parse(row.dataset.receivable)
    this.receivableValue = receivableData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const receivable = this.receivableValue

    this.clientNameTarget.textContent = receivable.client_name
    this.projectNameTarget.textContent = receivable.project_name
    this.invoiceNumberTarget.textContent = receivable.invoice_number
    this.billingDateTarget.textContent = receivable.billing_date
    this.dueDateTarget.textContent = receivable.due_date
    this.amountTarget.textContent = `¥${receivable.amount.toLocaleString()}`
    this.paidAmountTarget.textContent = `¥${receivable.paid_amount.toLocaleString()}`
    this.balanceTarget.textContent = `¥${receivable.balance.toLocaleString()}`

    this.updateStatus(receivable.status)
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '回収済':
        return 'bg-green-100 text-green-800'
      case '一部回収':
        return 'bg-blue-100 text-blue-800'
      case '未回収':
        return 'bg-yellow-100 text-yellow-800'
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
