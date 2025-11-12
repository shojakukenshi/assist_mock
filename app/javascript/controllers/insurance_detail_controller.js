import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "staffName", "staffCode", "insuranceType", "amount",
                   "paymentDate", "status", "coverage", "expiryDate"]

  static values = {
    insurance: Object
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
    const insuranceData = JSON.parse(row.dataset.insurance)
    this.insuranceValue = insuranceData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const insurance = this.insuranceValue

    this.staffNameTarget.textContent = insurance.staff_name
    this.staffCodeTarget.textContent = insurance.staff_code
    this.insuranceTypeTarget.textContent = insurance.insurance_type
    this.amountTarget.textContent = `¥${insurance.amount.toLocaleString()}`
    this.paymentDateTarget.textContent = insurance.payment_date
    this.coverageTarget.textContent = insurance.coverage
    this.expiryDateTarget.textContent = insurance.expiry_date || '-'

    this.updateStatus(insurance.status)
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
      case '支払予定':
        return 'bg-blue-100 text-blue-800'
      case '未納':
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
