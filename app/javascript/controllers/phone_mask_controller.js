import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.format()
  }

  format() {
    const digits = (this.element.value || "").replace(/\D/g, "").slice(0, 11)

    if (digits.length <= 2) {
      this.element.value = digits
      return
    }

    if (digits.length <= 6) {
      this.element.value = `(${digits.slice(0, 2)}) ${digits.slice(2)}`
      return
    }

    if (digits.length <= 10) {
      this.element.value = `(${digits.slice(0, 2)}) ${digits.slice(2, 6)}-${digits.slice(6)}`
      return
    }

    this.element.value = `(${digits.slice(0, 2)}) ${digits.slice(2, 7)}-${digits.slice(7)}`
  }
}

