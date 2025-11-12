import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form", "preview"]

  open(event) {
    const projectId = event.currentTarget.dataset.projectId

    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")

    // プロジェクトデータを読み込み
    if (projectId) {
      this.loadProjectData(projectId)
    }
  }

  close() {
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }

  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }

  loadProjectData(projectId) {
    console.log(`Loading project data for estimate: ${projectId}`)
  }

  updatePreview() {
    // フォーム入力から見積金額を計算
    const unitPrice = parseInt(this.formTarget.querySelector('[name="unit_price"]').value) || 0
    const staffCount = parseInt(this.formTarget.querySelector('[name="staff_count"]').value) || 0
    const months = parseInt(this.formTarget.querySelector('[name="months"]').value) || 0

    const subtotal = unitPrice * staffCount * months
    const tax = Math.floor(subtotal * 0.1)
    const total = subtotal + tax

    this.previewTarget.innerHTML = `
      <div class="space-y-2 text-sm">
        <div class="flex justify-between">
          <span class="text-gray-600">小計</span>
          <span class="font-medium">¥${subtotal.toLocaleString()}</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-600">消費税（10%）</span>
          <span class="font-medium">¥${tax.toLocaleString()}</span>
        </div>
        <div class="flex justify-between text-lg font-bold border-t pt-2">
          <span>合計金額</span>
          <span class="text-blue-600">¥${total.toLocaleString()}</span>
        </div>
      </div>
    `
  }

  submit(event) {
    event.preventDefault()

    alert("見積書を作成しました。PDF出力機能は実装予定です。")
    this.close()
  }
}
