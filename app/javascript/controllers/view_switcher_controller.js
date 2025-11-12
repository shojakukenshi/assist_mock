import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cardView", "tableView", "cardButton", "tableButton"]

  connect() {
    // デフォルトでテーブルビューを表示
    this.showTable()
  }

  showCards() {
    this.cardViewTarget.classList.remove("hidden")
    this.tableViewTarget.classList.add("hidden")

    // ボタンのスタイル更新
    this.cardButtonTarget.classList.remove("bg-white", "text-gray-700")
    this.cardButtonTarget.classList.add("bg-blue-600", "text-white")
    this.tableButtonTarget.classList.remove("bg-blue-600", "text-white")
    this.tableButtonTarget.classList.add("bg-white", "text-gray-700")

    // 状態を保存
    localStorage.setItem("clientViewMode", "cards")
  }

  showTable() {
    this.cardViewTarget.classList.add("hidden")
    this.tableViewTarget.classList.remove("hidden")

    // ボタンのスタイル更新
    this.tableButtonTarget.classList.remove("bg-white", "text-gray-700")
    this.tableButtonTarget.classList.add("bg-blue-600", "text-white")
    this.cardButtonTarget.classList.remove("bg-blue-600", "text-white")
    this.cardButtonTarget.classList.add("bg-white", "text-gray-700")

    // 状態を保存
    localStorage.setItem("clientViewMode", "table")
  }
}
