import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form", "preview", "checkbox", "bulkToolbar", "selectedCount"]

  connect() {
    console.log("Billing controller connected")
  }

  // 請求書作成モーダルを開く
  open() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      if (this.hasFormTarget) {
        this.formTarget.reset()
        this.updatePreview()
      }
    }
  }

  // モーダルを閉じる
  close() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
    }
  }

  // 背景クリックで閉じる
  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }

  // 金額プレビューを更新
  updatePreview() {
    if (!this.hasFormTarget || !this.hasPreviewTarget) return

    const form = this.formTarget
    const amount = parseFloat(form.querySelector('[name="amount"]')?.value || 0)
    const taxRate = parseFloat(form.querySelector('[name="tax_rate"]')?.value || 10) / 100

    const subtotal = amount
    const tax = Math.floor(subtotal * taxRate)
    const total = subtotal + tax

    this.previewTarget.innerHTML = `
      <div class="space-y-3">
        <div class="flex items-center justify-between">
          <span class="text-sm text-gray-600">小計</span>
          <span class="font-medium text-gray-900">${this.formatCurrency(subtotal)}</span>
        </div>
        <div class="flex items-center justify-between">
          <span class="text-sm text-gray-600">消費税（${taxRate * 100}%）</span>
          <span class="font-medium text-gray-900">${this.formatCurrency(tax)}</span>
        </div>
        <div class="border-t border-gray-300 pt-3">
          <div class="flex items-center justify-between">
            <span class="font-bold text-gray-900">合計金額</span>
            <span class="text-2xl font-bold text-blue-600">${this.formatCurrency(total)}</span>
          </div>
        </div>
      </div>
    `
  }

  // 通貨フォーマット
  formatCurrency(amount) {
    return `¥${amount.toLocaleString('ja-JP')}`
  }

  // フォーム送信
  submit(event) {
    event.preventDefault()

    // バリデーション
    if (!this.validateForm()) {
      return
    }

    // モック: フォームデータを収集
    const formData = new FormData(this.formTarget)
    console.log("請求書作成データ:", Object.fromEntries(formData))

    // 成功メッセージ（モック）
    alert("請求書を作成しました。PDF出力機能は開発中です。")

    // モーダルを閉じる
    this.close()
  }

  // フォームバリデーション
  validateForm() {
    const form = this.formTarget
    const client = form.querySelector('[name="client"]').value
    const amount = form.querySelector('[name="amount"]').value

    if (!client) {
      alert("クライアントを選択してください")
      return false
    }
    if (!amount || amount <= 0) {
      alert("金額を入力してください")
      return false
    }

    return true
  }

  // チェックボックス選択時
  toggleSelection() {
    if (!this.hasBulkToolbarTarget) return

    const selectedCount = this.checkboxTargets.filter(cb => cb.checked).length

    if (selectedCount > 0) {
      this.bulkToolbarTarget.classList.remove("hidden")
      if (this.hasSelectedCountTarget) {
        this.selectedCountTarget.textContent = selectedCount
      }
    } else {
      this.bulkToolbarTarget.classList.add("hidden")
    }
  }

  // 一括操作: PDFダウンロード
  bulkDownloadPDF() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    console.log("PDF一括ダウンロード:", selectedIds)
    alert(`${selectedIds.length}件の請求書をPDF出力します（開発中）`)
  }

  // 一括操作: 入金確認
  bulkMarkAsPaid() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    if (confirm(`${selectedIds.length}件の請求書を「入金済」にしますか？`)) {
      console.log("一括入金確認:", selectedIds)
      alert("入金ステータスを更新しました")
      // 実際のアプリではここでサーバーにリクエストを送信
    }
  }

  // ESCキーで閉じる
  handleKeyup(event) {
    if (event.key === "Escape" && this.hasModalTarget && !this.modalTarget.classList.contains("hidden")) {
      this.close()
    }
  }

  // 初期化時にキーイベントリスナーを追加
  initialize() {
    document.addEventListener("keyup", this.handleKeyup.bind(this))
  }

  // 切断時にキーイベントリスナーを削除
  disconnect() {
    document.removeEventListener("keyup", this.handleKeyup.bind(this))
  }
}
