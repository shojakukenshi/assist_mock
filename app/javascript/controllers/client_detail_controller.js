import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["pane", "overlay"]
  static values = { clientId: Number }

  open(event) {
    const clientId = event.currentTarget.dataset.clientId
    this.clientIdValue = clientId

    // Load client data (in production, this would be an AJAX call)
    this.loadClientData(clientId)

    // Show detail pane
    this.paneTarget.classList.remove("translate-x-full")
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    this.paneTarget.classList.add("translate-x-full")
    this.overlayTarget.classList.add("hidden")
  }

  loadClientData(clientId) {
    // Mock data loading - in production, fetch from server
    console.log(`Loading client data for ID: ${clientId}`)
  }

  closeOnEscape(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  connect() {
    document.addEventListener("keydown", this.closeOnEscape.bind(this))
  }

  disconnect() {
    document.removeEventListener("keydown", this.closeOnEscape.bind(this))
  }
}
