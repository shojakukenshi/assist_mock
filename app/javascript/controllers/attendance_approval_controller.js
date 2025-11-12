import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "bulkToolbar", "selectedCount", "modal", "rejectReason"]

  connect() {
    console.log("Attendance approval controller connected")
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
      alert("承認する勤怠データを選択してください")
      return
    }

    if (confirm(`${selectedIds.length}件の勤怠データを承認しますか？`)) {
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

  // 一括差戻しモーダルを開く
  openBulkRejectModal() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    if (selectedIds.length === 0) {
      alert("差戻す勤怠データを選択してください")
      return
    }

    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      if (this.hasRejectReasonTarget) {
        this.rejectReasonTarget.value = ""
      }
    }
  }

  // 一括差戻し実行
  executeBulkReject() {
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    const reason = this.hasRejectReasonTarget ? this.rejectReasonTarget.value : ""

    if (!reason || reason.trim() === "") {
      alert("差戻し理由を入力してください")
      return
    }

    console.log("一括差戻し:", selectedIds, "理由:", reason)

    // モック: 差戻し処理
    alert(`${selectedIds.length}件を差戻しました`)

    // チェックボックスをクリア
    this.checkboxTargets.forEach(cb => cb.checked = false)
    this.updateToolbar()

    // モーダルを閉じる
    this.closeModal()

    // 実際のアプリではここでサーバーにリクエスト送信
  }

  // 個別承認
  approve(event) {
    const button = event.currentTarget
    const attendanceId = button.dataset.attendanceId
    const staffName = button.dataset.staffName || "このスタッフ"
    const date = button.dataset.date || ""

    if (confirm(`${staffName}の${date}の勤怠データを承認しますか？`)) {
      console.log("承認:", attendanceId)
      alert("承認しました")

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後に行のステータスバッジを更新
    }
  }

  // 個別差戻し
  reject(event) {
    const button = event.currentTarget
    const attendanceId = button.dataset.attendanceId
    const staffName = button.dataset.staffName || "このスタッフ"
    const date = button.dataset.date || ""

    const reason = prompt(`${staffName}の${date}の勤怠データを差戻します\n差戻し理由を入力してください`)

    if (reason && reason.trim() !== "") {
      console.log("差戻し:", attendanceId, "理由:", reason)
      alert("差戻しました")

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後に行のステータスバッジを更新
    }
  }

  // 勤怠詳細を表示
  showDetail(event) {
    const button = event.currentTarget
    const attendanceId = button.dataset.attendanceId

    console.log("勤怠詳細表示:", attendanceId)

    // 実際のアプリではここで詳細情報を取得してモーダル表示
    alert("勤怠詳細を表示（開発中）")
  }

  // 勤怠修正
  edit(event) {
    const button = event.currentTarget
    const attendanceId = button.dataset.attendanceId

    console.log("勤怠修正:", attendanceId)

    // 実際のアプリではここで編集画面を表示
    alert("勤怠修正画面を表示（開発中）")
  }

  // CSV出力
  exportCSV() {
    console.log("CSV出力")

    // 選択されたデータまたは全データを出力
    const selectedIds = this.checkboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.value)

    if (selectedIds.length > 0) {
      alert(`選択した${selectedIds.length}件をCSV出力します（開発中）`)
    } else {
      alert("全データをCSV出力します（開発中）")
    }

    // 実際のアプリではここでサーバーにリクエスト送信
  }

  // Excel出力
  exportExcel() {
    console.log("Excel出力")
    alert("Excelファイルを出力します（開発中）")

    // 実際のアプリではここでサーバーにリクエスト送信
  }

  // モーダルを閉じる
  closeModal() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
    }
  }

  // 背景クリックで閉じる
  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.closeModal()
    }
  }

  // ESCキーで閉じる
  handleKeyup(event) {
    if (event.key === "Escape" && this.hasModalTarget && !this.modalTarget.classList.contains("hidden")) {
      this.closeModal()
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
