import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "toolbar", "count"]

  connect() {
    this.updateToolbar()
  }

  toggle(event) {
    this.updateToolbar()
  }

  selectAll(event) {
    const checked = event.target.checked
    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = checked
    })
    this.updateToolbar()
  }

  updateToolbar() {
    const selectedCount = this.checkboxTargets.filter(cb => cb.checked).length

    if (selectedCount > 0) {
      this.toolbarTarget.classList.remove("hidden")
      this.countTarget.textContent = selectedCount
    } else {
      this.toolbarTarget.classList.add("hidden")
    }
  }

  bulkAction(event) {
    const action = event.currentTarget.dataset.action
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    console.log(`Bulk action: ${action}`, selectedIds)
    // In production, send to server
    alert(`${action}を${selectedIds.length}件のクライアントに実行します`)
  }
}
