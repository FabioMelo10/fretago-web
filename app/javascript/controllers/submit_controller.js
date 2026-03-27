import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.element.addEventListener("submit", this.handleSubmit)
  }

  disconnect() {
    this.element.removeEventListener("submit", this.handleSubmit)
  }

  handleSubmit = () => {
    if (!this.hasButtonTarget) return

    this.buttonTarget.disabled = true
    this.buttonTarget.dataset.originalText = this.buttonTarget.value
    this.buttonTarget.value = this.buttonTarget.dataset.submitLoadingText || "Enviando..."
  }
}

