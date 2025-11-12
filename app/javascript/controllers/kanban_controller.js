import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "column", "detailPane", "overlay"]

  connect() {
    console.log("Kanban controller connected")
    this.draggedCard = null
  }

  // カードのドラッグ開始
  dragStart(event) {
    this.draggedCard = event.currentTarget
    this.draggedCard.classList.add("opacity-50")
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/html", this.draggedCard.innerHTML)
  }

  // カードのドラッグ終了
  dragEnd(event) {
    if (this.draggedCard) {
      this.draggedCard.classList.remove("opacity-50")
    }

    // 全てのドロップゾーンのハイライトをクリア
    this.columnTargets.forEach(column => {
      column.classList.remove("bg-blue-50", "border-blue-300")
    })
  }

  // ドロップゾーンに入った時
  dragEnter(event) {
    event.preventDefault()
    const column = event.currentTarget
    column.classList.add("bg-blue-50", "border-blue-300")
  }

  // ドロップゾーンから出た時
  dragLeave(event) {
    const column = event.currentTarget
    column.classList.remove("bg-blue-50", "border-blue-300")
  }

  // ドロップゾーンの上にいる時
  dragOver(event) {
    event.preventDefault()
    event.dataTransfer.dropEffect = "move"
  }

  // カードをドロップした時
  drop(event) {
    event.preventDefault()
    const column = event.currentTarget
    column.classList.remove("bg-blue-50", "border-blue-300")

    if (this.draggedCard) {
      // カードを新しいカラムに移動
      const cardsContainer = column.querySelector('[data-kanban-cards]')
      if (cardsContainer) {
        cardsContainer.appendChild(this.draggedCard)

        // ステータスを更新（モック）
        const newStatus = column.dataset.stage
        console.log(`案件を "${newStatus}" に移動しました`)

        // カウント更新（モック）
        this.updateColumnCounts()

        // 成功メッセージを表示（実際のアプリではToast通知など）
        this.showSuccessMessage(newStatus)
      }
    }
  }

  // カラムのカウントを更新
  updateColumnCounts() {
    this.columnTargets.forEach(column => {
      const cardsContainer = column.querySelector('[data-kanban-cards]')
      const count = cardsContainer ? cardsContainer.children.length : 0
      const badge = column.querySelector('[data-kanban-count]')
      if (badge) {
        badge.textContent = count
      }
    })
  }

  // 成功メッセージを表示（簡易版）
  showSuccessMessage(status) {
    // 実際のアプリではToast通知コンポーネントを使用
    console.log(`✓ ステータスを「${status}」に更新しました`)
  }

  // カードクリックで詳細パネルを開く
  openDetail(event) {
    // ドラッグ中はクリックイベントを無視
    if (this.draggedCard) return

    const card = event.currentTarget
    const dealId = card.dataset.dealId

    // 詳細パネルを開く
    if (this.hasDetailPaneTarget && this.hasOverlayTarget) {
      this.overlayTarget.classList.remove("hidden")
      this.detailPaneTarget.classList.remove("translate-x-full")

      // 詳細データをロード（モック）
      console.log(`案件ID ${dealId} の詳細を表示`)
    }
  }

  // 詳細パネルを閉じる
  closeDetail() {
    if (this.hasDetailPaneTarget && this.hasOverlayTarget) {
      this.detailPaneTarget.classList.add("translate-x-full")
      this.overlayTarget.classList.add("hidden")
    }
  }

  // ESCキーで詳細パネルを閉じる
  handleKeyup(event) {
    if (event.key === "Escape") {
      this.closeDetail()
    }
  }

  // 初期接続時にイベントリスナーを設定
  initialize() {
    document.addEventListener("keyup", this.handleKeyup.bind(this))
  }

  // 切断時にイベントリスナーを削除
  disconnect() {
    document.removeEventListener("keyup", this.handleKeyup.bind(this))
  }
}
