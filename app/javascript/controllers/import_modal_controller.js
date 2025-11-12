import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "dropzone", "fileInput", "preview"]

  open() {
    this.modalTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
    this.resetForm()
  }

  closeOnBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close()
    }
  }

  selectFile() {
    this.fileInputTarget.click()
  }

  handleFile(event) {
    const files = event.target.files || event.dataTransfer.files
    if (files.length > 0) {
      this.processFile(files[0])
    }
  }

  handleDrop(event) {
    event.preventDefault()
    this.dropzoneTarget.classList.remove("border-blue-500", "bg-blue-50")
    this.handleFile(event)
  }

  handleDragOver(event) {
    event.preventDefault()
    this.dropzoneTarget.classList.add("border-blue-500", "bg-blue-50")
  }

  handleDragLeave(event) {
    event.preventDefault()
    this.dropzoneTarget.classList.remove("border-blue-500", "bg-blue-50")
  }

  processFile(file) {
    console.log("Processing file:", file.name)

    // ファイル情報を表示
    this.previewTarget.innerHTML = `
      <div class="text-sm text-gray-700">
        <p class="font-medium">選択されたファイル:</p>
        <p class="text-gray-600 mt-1">${file.name} (${(file.size / 1024).toFixed(2)} KB)</p>
      </div>
    `

    // 本番環境ではここでファイルをアップロード・解析
  }

  submit(event) {
    event.preventDefault()

    // モック: インポート成功
    alert("案件データを10件インポートしました")
    this.close()
  }

  resetForm() {
    this.fileInputTarget.value = ""
    this.previewTarget.innerHTML = ""
  }
}
