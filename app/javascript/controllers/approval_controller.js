import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "bulkToolbar", "selectedCount", "approveButton", "rejectButton"]

  connect() {
    console.log("Approval controller connected")
    this.updateToolbar()
  }

  // チェックボックス選択時
  toggleSelection() {
    this.updateToolbar()
  }

  // 全選択
  selectAll(event) {
    const checked = event.target.checked
    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = checked
    })
    this.updateToolbar()
  }

  // ツールバー表示更新
  updateToolbar() {
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

  // 一括承認
  bulkApprove() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    if (selectedIds.length === 0) {
      alert("承認する項目を選択してください")
      return
    }

    if (confirm(`${selectedIds.length}件を承認しますか？`)) {
      console.log("一括承認:", selectedIds)

      // モック: 承認処理
      alert(`${selectedIds.length}件を承認しました`)

      // チェックボックスをクリア
      this.checkboxTargets.forEach(cb => cb.checked = false)
      this.updateToolbar()

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後にページリロードまたはTurboでリスト更新
    }
  }

  // 一括差戻し
  bulkReject() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    if (selectedIds.length === 0) {
      alert("差戻す項目を選択してください")
      return
    }

    const reason = prompt(`差戻し理由を入力してください\n（${selectedIds.length}件選択中）`)

    if (reason && reason.trim() !== "") {
      console.log("一括差戻し:", selectedIds, "理由:", reason)

      // モック: 差戻し処理
      alert(`${selectedIds.length}件を差戻しました`)

      // チェックボックスをクリア
      this.checkboxTargets.forEach(cb => cb.checked = false)
      this.updateToolbar()

      // 実際のアプリではここでサーバーにリクエスト送信
    }
  }

  // 個別承認
  approve(event) {
    const button = event.currentTarget
    const itemId = button.dataset.itemId
    const itemName = button.dataset.itemName || "この項目"

    if (confirm(`${itemName}を承認しますか？`)) {
      console.log("承認:", itemId)
      alert("承認しました")

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後に行のステータスバッジを更新
    }
  }

  // 個別差戻し
  reject(event) {
    const button = event.currentTarget
    const itemId = button.dataset.itemId
    const itemName = button.dataset.itemName || "この項目"

    const reason = prompt(`${itemName}を差戻します\n差戻し理由を入力してください`)

    if (reason && reason.trim() !== "") {
      console.log("差戻し:", itemId, "理由:", reason)
      alert("差戻しました")

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後に行のステータスバッジを更新
    }
  }
}
