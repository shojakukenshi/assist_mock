import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "date", "category", "amount", "vendor",
                   "description", "status", "approver", "approvedDate", "paymentDate"]

  static values = {
    expense: Object
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
    const expenseData = JSON.parse(row.dataset.accountingExpense)
    this.expenseValue = expenseData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const expense = this.expenseValue

    this.dateTarget.textContent = expense.date
    this.categoryTarget.textContent = expense.category
    this.amountTarget.textContent = `¥${expense.amount.toLocaleString()}`
    this.vendorTarget.textContent = expense.vendor
    this.descriptionTarget.textContent = expense.description

    this.updateStatus(expense.status)

    this.approverTarget.textContent = expense.approver || '-'
    this.approvedDateTarget.textContent = expense.approved_date || '-'
    this.paymentDateTarget.textContent = expense.payment_date || '-'
  }

  updateStatus(status) {
    const classes = this.getStatusClasses(status)
    this.statusTarget.className = `inline-flex px-3 py-1 text-sm font-semibold rounded-full ${classes}`
    this.statusTarget.textContent = status
  }

  getStatusClasses(status) {
    switch (status) {
      case '支払済':
        return 'bg-green-100 text-green-800'
      case '承認済':
        return 'bg-blue-100 text-blue-800'
      case '承認待ち':
        return 'bg-yellow-100 text-yellow-800'
      case '却下':
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
