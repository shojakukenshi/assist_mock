import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]
  static values = { id: String }

  connect() {
    // ローカルストレージから状態を復元
    const isOpen = localStorage.getItem(`accordion-${this.idValue}`) === "true"
    if (isOpen) {
      this.open()
    }
  }

  toggle() {
    if (this.contentTarget.classList.contains("hidden")) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.contentTarget.classList.remove("hidden")
    this.iconTarget.style.transform = "rotate(180deg)"
    localStorage.setItem(`accordion-${this.idValue}`, "true")
  }

  close() {
    this.contentTarget.classList.add("hidden")
    this.iconTarget.style.transform = "rotate(0deg)"
    localStorage.setItem(`accordion-${this.idValue}`, "false")
  }
}
