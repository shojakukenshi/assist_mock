import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  open(event) {
    const clientId = event.currentTarget.dataset.clientId

    // モーダルを表示
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")

    // フォームにクライアントIDを設定
    if (clientId) {
      this.loadClientData(clientId)
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

  submit(event) {
    event.preventDefault()

    // フォームデータを取得
    const formData = new FormData(this.formTarget)
    const data = Object.fromEntries(formData.entries())

    console.log("Submitting client data:", data)

    // 成功メッセージを表示
    alert("クライアント情報を更新しました")
    this.close()

    // 本番環境では、ここでAJAXリクエストを送信
  }

  loadClientData(clientId) {
    // モックデータ読み込み
    console.log(`Loading client data for ID: ${clientId}`)

    // 本番環境では、ここでAJAXリクエストでデータを取得してフォームに設定
  }
}
