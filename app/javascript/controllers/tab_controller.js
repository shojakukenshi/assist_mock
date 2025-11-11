import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "tab"]

  switch(event) {
    const tabName = event.currentTarget.dataset.tab

    // Update tab styles
    this.tabTargets.forEach(tab => {
      if (tab.dataset.tab === tabName) {
        tab.classList.remove("border-transparent", "text-gray-500")
        tab.classList.add("border-blue-500", "text-blue-600")
      } else {
        tab.classList.remove("border-blue-500", "text-blue-600")
        tab.classList.add("border-transparent", "text-gray-500")
      }
    })

    // Update content visibility
    this.contentTargets.forEach(content => {
      if (content.dataset.tabContent === tabName) {
        content.classList.remove("hidden")
      } else {
        content.classList.add("hidden")
      }
    })
  }
}
