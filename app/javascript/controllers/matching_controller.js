import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "candidateList", "selectedProject", "matchingScore"]

  connect() {
    console.log("Matching controller connected")
  }

  // マッチングモーダルを開く
  openMatching(event) {
    const button = event.currentTarget
    const projectId = button.dataset.projectId
    const projectName = button.dataset.projectName

    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      if (this.hasSelectedProjectTarget) {
        this.selectedProjectTarget.textContent = projectName
      }

      // 実際のアプリではここでサーバーからマッチング候補を取得
      console.log("マッチング候補を取得:", projectId)
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

  // スタッフをアサイン
  assignStaff(event) {
    const button = event.currentTarget
    const staffId = button.dataset.staffId
    const staffName = button.dataset.staffName
    const projectName = this.hasSelectedProjectTarget ? this.selectedProjectTarget.textContent : "この案件"
    const matchingScore = button.dataset.matchingScore

    if (confirm(`${staffName}を${projectName}にアサインしますか？\n\nマッチングスコア: ${matchingScore}点`)) {
      console.log("スタッフアサイン:", { staffId, projectName, matchingScore })

      // モック: アサイン処理
      alert(`${staffName}をアサインしました`)

      this.close()

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後にページリロードまたはTurboでリスト更新
    }
  }

  // 候補詳細を表示
  showCandidateDetail(event) {
    const button = event.currentTarget
    const staffId = button.dataset.staffId
    const staffName = button.dataset.staffName

    console.log("候補詳細表示:", staffId)

    // 実際のアプリではここで詳細情報を取得してモーダル内に表示
    alert(`${staffName}の詳細情報を表示（開発中）`)
  }

  // AIマッチング再実行
  rerunMatching() {
    console.log("AIマッチング再実行")

    // モック: マッチング処理
    alert("AIマッチングを再実行しています...\n\n新しい候補が見つかりました")

    // 実際のアプリではここでサーバーにリクエスト送信
    // 候補リストを更新
  }

  // マッチング条件を調整
  adjustCriteria() {
    console.log("マッチング条件調整")

    // モック: 条件調整画面を表示
    const newCriteria = prompt("マッチング条件を入力してください\n（例: スキルレベル,単価上限,勤務地）")

    if (newCriteria && newCriteria.trim() !== "") {
      console.log("新しい条件:", newCriteria)
      alert("マッチング条件を更新しました")

      // 実際のアプリではここでサーバーにリクエスト送信
      // 条件を保存して候補リストを更新
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
