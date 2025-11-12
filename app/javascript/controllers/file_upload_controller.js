import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropzone", "input", "preview"]

  connect() {
    console.log("File upload controller connected")
  }

  // ドロップゾーンクリックでファイル選択
  selectFile() {
    if (this.hasInputTarget) {
      this.inputTarget.click()
    }
  }

  // ファイルが選択された時
  handleFile(event) {
    const files = event.target.files || event.dataTransfer.files
    if (files.length > 0) {
      this.processFile(files[0])
    }
  }

  // ファイルを処理
  processFile(file) {
    console.log("Selected file:", file.name, file.type, file.size)

    // ファイルタイプのバリデーション
    const validTypes = ["application/pdf", "image/jpeg", "image/jpg", "image/png", "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]
    if (!validTypes.includes(file.type)) {
      alert("対応していないファイル形式です。PDF、JPG、PNG、またはExcelファイルを選択してください。")
      return
    }

    // ファイルサイズのバリデーション（10MB）
    if (file.size > 10 * 1024 * 1024) {
      alert("ファイルサイズが大きすぎます。10MB以下のファイルを選択してください。")
      return
    }

    // プレビューを表示
    if (this.hasPreviewTarget) {
      this.showPreview(file)
    }
  }

  // プレビューを表示
  showPreview(file) {
    const fileSize = this.formatFileSize(file.size)
    const fileType = this.getFileTypeLabel(file.type)

    this.previewTarget.innerHTML = `
      <div class="border-2 border-green-300 bg-green-50 rounded-lg p-4">
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <svg class="w-10 h-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <div class="ml-3">
              <div class="text-sm font-medium text-gray-900">${file.name}</div>
              <div class="text-xs text-gray-500">${fileType} • ${fileSize}</div>
            </div>
          </div>
          <button type="button"
                  class="text-red-600 hover:text-red-800"
                  data-action="click->file-upload#removeFile">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    `
  }

  // ファイルを削除
  removeFile() {
    if (this.hasInputTarget) {
      this.inputTarget.value = ""
    }
    if (this.hasPreviewTarget) {
      this.previewTarget.innerHTML = ""
    }
  }

  // ドラッグオーバー
  handleDragOver(event) {
    event.preventDefault()
    event.stopPropagation()
    if (this.hasDropzoneTarget) {
      this.dropzoneTarget.classList.add("border-blue-500", "bg-blue-50")
    }
  }

  // ドラッグリーブ
  handleDragLeave(event) {
    event.preventDefault()
    event.stopPropagation()
    if (this.hasDropzoneTarget) {
      this.dropzoneTarget.classList.remove("border-blue-500", "bg-blue-50")
    }
  }

  // ドロップ
  handleDrop(event) {
    event.preventDefault()
    event.stopPropagation()

    if (this.hasDropzoneTarget) {
      this.dropzoneTarget.classList.remove("border-blue-500", "bg-blue-50")
    }

    this.handleFile(event)
  }

  // ファイルサイズをフォーマット
  formatFileSize(bytes) {
    if (bytes < 1024) return bytes + " B"
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + " KB"
    return (bytes / (1024 * 1024)).toFixed(1) + " MB"
  }

  // ファイルタイプラベルを取得
  getFileTypeLabel(type) {
    if (type.includes("pdf")) return "PDF"
    if (type.includes("image")) return "画像"
    if (type.includes("excel") || type.includes("spreadsheet")) return "Excel"
    return "ファイル"
  }
}
