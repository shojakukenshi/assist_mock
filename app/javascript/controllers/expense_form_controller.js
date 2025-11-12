import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form", "fileInput", "filePreview", "fileName"]

  connect() {
    console.log("Expense form controller connected")
  }

  // モーダルを開く
  open() {
    this.modalTarget.classList.remove("hidden")
    // フォームをリセット
    if (this.hasFormTarget) {
      this.formTarget.reset()
      this.clearFilePreview()
    }
  }

  // モーダルを閉じる
  close() {
    this.modalTarget.classList.add("hidden")
  }

  // 背景クリックで閉じる
  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }

  // ESCキーで閉じる
  handleKeyup(event) {
    if (event.key === "Escape" && !this.modalTarget.classList.contains("hidden")) {
      this.close()
    }
  }

  // ファイル選択ダイアログを開く
  selectFile() {
    if (this.hasFileInputTarget) {
      this.fileInputTarget.click()
    }
  }

  // ファイルが選択された時
  handleFileSelect(event) {
    const files = event.target.files
    if (files.length > 0) {
      this.showFilePreview(files[0])
    }
  }

  // ファイルプレビューを表示
  showFilePreview(file) {
    if (!this.hasFilePreviewTarget) return

    const fileType = file.type
    const fileName = file.name
    const fileSize = this.formatFileSize(file.size)

    // ファイル名を表示
    if (this.hasFileNameTarget) {
      this.fileNameTarget.textContent = `${fileName} (${fileSize})`
    }

    // プレビューを表示
    this.filePreviewTarget.innerHTML = `
      <div class="border border-gray-300 rounded-lg p-4 bg-gray-50">
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            ${this.getFileIcon(fileType)}
            <div class="ml-3">
              <div class="text-sm font-medium text-gray-900">${fileName}</div>
              <div class="text-xs text-gray-500">${fileSize}</div>
            </div>
          </div>
          <button type="button"
                  class="text-red-600 hover:text-red-800"
                  data-action="click->expense-form#removeFile">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    `
    this.filePreviewTarget.classList.remove("hidden")
  }

  // ファイルアイコンを取得
  getFileIcon(fileType) {
    if (fileType.includes("pdf")) {
      return `<svg class="w-10 h-10 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4z" clip-rule="evenodd" />
              </svg>`
    } else if (fileType.includes("image")) {
      return `<svg class="w-10 h-10 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>`
    } else {
      return `<svg class="w-10 h-10 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
              </svg>`
    }
  }

  // ファイルサイズをフォーマット
  formatFileSize(bytes) {
    if (bytes < 1024) return bytes + " B"
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + " KB"
    return (bytes / (1024 * 1024)).toFixed(1) + " MB"
  }

  // ファイルを削除
  removeFile() {
    if (this.hasFileInputTarget) {
      this.fileInputTarget.value = ""
    }
    this.clearFilePreview()
  }

  // ファイルプレビューをクリア
  clearFilePreview() {
    if (this.hasFilePreviewTarget) {
      this.filePreviewTarget.innerHTML = ""
      this.filePreviewTarget.classList.add("hidden")
    }
    if (this.hasFileNameTarget) {
      this.fileNameTarget.textContent = ""
    }
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
    console.log("経費登録データ:", Object.fromEntries(formData))

    // 成功メッセージ（モック）
    alert("経費を登録しました。承認待ちとして保存されました。")

    // モーダルを閉じる
    this.close()

    // ページをリロード（実際のアプリではTurboでリスト更新）
    // location.reload()
  }

  // フォームバリデーション
  validateForm() {
    const form = this.formTarget
    const date = form.querySelector('[name="date"]').value
    const category = form.querySelector('[name="category"]').value
    const amount = form.querySelector('[name="amount"]').value

    if (!date) {
      alert("日付を入力してください")
      return false
    }
    if (!category) {
      alert("費目を選択してください")
      return false
    }
    if (!amount || amount <= 0) {
      alert("金額を入力してください")
      return false
    }

    return true
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
