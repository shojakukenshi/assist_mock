import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "staffName", "staffCode", "month", "basicSalary",
                   "overtime", "deductions", "netSalary", "status", "paymentDate"]

  static values = {
    payroll: Object
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
    const payrollData = JSON.parse(row.dataset.payroll)
    this.payrollValue = payrollData
    this.updatePanel()
    this.showPanel()
  }

  updatePanel() {
    const payroll = this.payrollValue

    this.staffNameTarget.textContent = payroll.staff_name
    this.staffCodeTarget.textContent = payroll.staff_code
    this.monthTarget.textContent = payroll.month
    this.basicSalaryTarget.textContent = `¥${payroll.basic_salary.toLocaleString()}`
    this.overtimeTarget.textContent = `¥${payroll.overtime_pay.toLocaleString()}`
    this.deductionsTarget.textContent = `¥${payroll.deductions.toLocaleString()}`
    this.netSalaryTarget.textContent = `¥${payroll.net_salary.toLocaleString()}`
    this.paymentDateTarget.textContent = payroll.payment_date

    this.updateStatus(payroll.status)
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
      case '確認中':
        return 'bg-yellow-100 text-yellow-800'
      case '未確定':
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
