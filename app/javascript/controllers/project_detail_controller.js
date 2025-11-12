import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["pane", "overlay"]

  open(event) {
    const projectId = event.currentTarget.dataset.projectId

    // Load project data
    this.loadProjectData(projectId)

    // Show detail pane
    this.paneTarget.classList.remove("translate-x-full")
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    this.paneTarget.classList.add("translate-x-full")
    this.overlayTarget.classList.add("hidden")
  }

  loadProjectData(projectId) {
    console.log(`Loading project data for ID: ${projectId}`)
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
