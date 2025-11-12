import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["chatModal", "chatMessages", "messageInput", "inquiryId", "inquiryTitle"]

  connect() {
    console.log("Support chat controller connected")
  }

  // チャットモーダルを開く
  openChat(event) {
    const button = event.currentTarget
    const inquiryId = button.dataset.inquiryId
    const inquiryTitle = button.dataset.inquiryTitle || "問い合わせ"

    if (this.hasChatModalTarget) {
      this.chatModalTarget.classList.remove("hidden")

      if (this.hasInquiryIdTarget) {
        this.inquiryIdTarget.value = inquiryId
      }

      if (this.hasInquiryTitleTarget) {
        this.inquiryTitleTarget.textContent = inquiryTitle
      }

      // 実際のアプリではここでサーバーからチャット履歴を取得
      console.log("チャット履歴を取得:", inquiryId)

      // メッセージエリアを最下部にスクロール
      this.scrollToBottom()
    }
  }

  // チャットを閉じる
  closeChat() {
    if (this.hasChatModalTarget) {
      this.chatModalTarget.classList.add("hidden")
    }
  }

  // 背景クリックで閉じる
  closeOnBackdrop(event) {
    if (event.target === this.chatModalTarget) {
      this.closeChat()
    }
  }

  // メッセージ送信
  sendMessage(event) {
    event.preventDefault()

    if (!this.hasMessageInputTarget) return

    const message = this.messageInputTarget.value.trim()

    if (message === "") {
      alert("メッセージを入力してください")
      return
    }

    const inquiryId = this.hasInquiryIdTarget ? this.inquiryIdTarget.value : null

    console.log("メッセージ送信:", { inquiryId, message })

    // モック: メッセージを追加
    this.addMessageToChat("support", "サポート担当", message)

    // 入力欄をクリア
    this.messageInputTarget.value = ""

    // スクロールを最下部へ
    this.scrollToBottom()

    // 実際のアプリではここでサーバーにリクエスト送信
    // 成功後にチャット履歴を更新
  }

  // チャットにメッセージを追加（モック用）
  addMessageToChat(senderType, senderName, message) {
    if (!this.hasChatMessagesTarget) return

    const timestamp = new Date().toLocaleString("ja-JP", {
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    })

    const messageHtml = `
      <div class="flex ${senderType === "support" ? "justify-end" : "justify-start"}">
        <div class="max-w-[70%]">
          <div class="flex items-center gap-2 mb-1">
            <span class="text-xs font-medium text-gray-600">${senderName}</span>
            <span class="text-xs text-gray-400">${timestamp}</span>
          </div>
          <div class="rounded-lg p-3 ${
            senderType === "support"
              ? "bg-blue-500 text-white"
              : "bg-gray-100 text-gray-900"
          }">
            ${message}
          </div>
        </div>
      </div>
    `

    this.chatMessagesTarget.insertAdjacentHTML("beforeend", messageHtml)
  }

  // チャットを最下部にスクロール
  scrollToBottom() {
    if (this.hasChatMessagesTarget) {
      setTimeout(() => {
        this.chatMessagesTarget.scrollTop = this.chatMessagesTarget.scrollHeight
      }, 100)
    }
  }

  // 問い合わせステータス変更
  changeStatus(event) {
    const button = event.currentTarget
    const inquiryId = button.dataset.inquiryId
    const currentStatus = button.dataset.currentStatus
    const newStatus = button.dataset.newStatus

    if (confirm(`ステータスを「${currentStatus}」から「${newStatus}」に変更しますか？`)) {
      console.log("ステータス変更:", { inquiryId, currentStatus, newStatus })
      alert(`ステータスを「${newStatus}」に変更しました`)

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後にステータスバッジを更新
    }
  }

  // 問い合わせを完了
  closeInquiry(event) {
    const button = event.currentTarget
    const inquiryId = button.dataset.inquiryId

    if (confirm("この問い合わせを完了しますか？")) {
      console.log("問い合わせ完了:", inquiryId)
      alert("問い合わせを完了しました")

      this.closeChat()

      // 実際のアプリではここでサーバーにリクエスト送信
      // 成功後にリストを更新
    }
  }

  // 担当者アサイン
  assignSupport(event) {
    const button = event.currentTarget
    const inquiryId = button.dataset.inquiryId

    const assignee = prompt("担当者を選択してください\n（例: サポート担当A, サポート担当B）")

    if (assignee && assignee.trim() !== "") {
      console.log("担当者アサイン:", { inquiryId, assignee })
      alert(`担当者を「${assignee}」にアサインしました`)

      // 実際のアプリではここでサーバーにリクエスト送信
    }
  }

  // お知らせ作成モーダルを開く
  openAnnouncementModal() {
    console.log("お知らせ作成")
    alert("お知らせ作成画面を表示（開発中）")

    // 実際のアプリではここでモーダルを表示
  }

  // FAQ作成モーダルを開く
  openFaqModal() {
    console.log("FAQ作成")
    alert("FAQ作成画面を表示（開発中）")

    // 実際のアプリではここでモーダルを表示
  }

  // お知らせ詳細を表示
  showAnnouncement(event) {
    const button = event.currentTarget
    const announcementId = button.dataset.announcementId
    const title = button.dataset.title

    console.log("お知らせ詳細:", announcementId)
    alert(`「${title}」の詳細を表示（開発中）`)

    // 実際のアプリではここで詳細モーダルを表示
  }

  // FAQ詳細を表示
  showFaq(event) {
    const button = event.currentTarget
    const faqId = button.dataset.faqId
    const question = button.dataset.question

    console.log("FAQ詳細:", faqId)
    alert(`「${question}」の詳細を表示（開発中）`)

    // 実際のアプリではここで詳細モーダルを表示
  }

  // ESCキーで閉じる
  handleKeyup(event) {
    if (event.key === "Escape" && this.hasChatModalTarget && !this.chatModalTarget.classList.contains("hidden")) {
      this.closeChat()
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
