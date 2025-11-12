import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form", "progressBar", "progressText", "statusMessage"]

  connect() {
    console.log("Closing controller connected")
  }

  // 月次締め実行モーダルを開く
  open() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      if (this.hasProgressBarTarget) {
        this.progressBarTarget.style.width = "0%"
      }
      if (this.hasProgressTextTarget) {
        this.progressTextTarget.textContent = "0%"
      }
      if (this.hasStatusMessageTarget) {
        this.statusMessageTarget.textContent = "準備中..."
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

  // 月次締め処理実行
  executeClosing(event) {
    event.preventDefault()

    const period = this.element.querySelector('[name="period"]').value

    if (!period) {
      alert("締め期間を選択してください")
      return
    }

    if (!confirm(`${period}の月次締め処理を実行しますか？\n\n※実行後は当月のデータ編集ができなくなります`)) {
      return
    }

    // 締め処理開始
    this.startClosing(period)
  }

  // 締め処理のシミュレーション
  async startClosing(period) {
    console.log("月次締め処理開始:", period)

    const steps = [
      { progress: 10, message: "売上データを集計中..." },
      { progress: 25, message: "経費データを集計中..." },
      { progress: 40, message: "給与データを集計中..." },
      { progress: 55, message: "債権データを確認中..." },
      { progress: 70, message: "仕訳データを検証中..." },
      { progress: 85, message: "試算表を生成中..." },
      { progress: 95, message: "最終チェック中..." },
      { progress: 100, message: "月次締め完了！" }
    ]

    for (const step of steps) {
      await this.sleep(500) // 0.5秒待機
      this.updateProgress(step.progress, step.message)
    }

    // 完了メッセージ
    await this.sleep(1000)
    alert(`${period}の月次締め処理が完了しました`)

    // モーダルを閉じてページリロード（実際のアプリではTurboでリスト更新）
    this.close()
    // location.reload()
  }

  // 進捗表示更新
  updateProgress(progress, message) {
    if (this.hasProgressBarTarget) {
      this.progressBarTarget.style.width = `${progress}%`
    }
    if (this.hasProgressTextTarget) {
      this.progressTextTarget.textContent = `${progress}%`
    }
    if (this.hasStatusMessageTarget) {
      this.statusMessageTarget.textContent = message
    }
  }

  // 月次締め解除
  unlockClosing(event) {
    const button = event.currentTarget
    const period = button.dataset.period

    if (!confirm(`${period}の月次締めを解除しますか？\n\n※データの編集が可能になります`)) {
      return
    }

    console.log("月次締め解除:", period)
    alert(`${period}の月次締めを解除しました`)

    // 実際のアプリではここでサーバーにリクエスト送信
    // 成功後にステータスを更新
  }

  // CSV出力
  exportCSV(event) {
    const button = event.currentTarget
    const reportType = button.dataset.reportType || "試算表"

    console.log("CSV出力:", reportType)
    alert(`${reportType}をCSV形式で出力します（開発中）`)

    // 実際のアプリではここでサーバーにリクエスト送信
    // CSVファイルをダウンロード
  }

  // PDF出力
  exportPDF(event) {
    const button = event.currentTarget
    const reportType = button.dataset.reportType || "試算表"

    console.log("PDF出力:", reportType)
    alert(`${reportType}をPDF形式で出力します（開発中）`)

    // 実際のアプリではここでサーバーにリクエスト送信
    // PDFファイルをダウンロード
  }

  // ユーティリティ: スリープ
  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
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
