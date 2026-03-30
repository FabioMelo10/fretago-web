import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { defaultTab: String }

  connect() {
    const initialTabId = this.defaultTabValue || this.tabTargets[0]?.dataset.tabId
    if (initialTabId) this.activate(initialTabId)
  }

  select(event) {
    event.preventDefault()
    const tabId = event.currentTarget.dataset.tabId
    if (!tabId) return

    this.activate(tabId)
  }

  activate(tabId) {
    this.tabTargets.forEach((tab) => {
      const active = tab.dataset.tabId === tabId
      tab.setAttribute("aria-selected", active.toString())
      tab.classList.toggle("border-emerald-500", active)
      tab.classList.toggle("text-emerald-300", active)
      tab.classList.toggle("font-semibold", active)
      tab.classList.toggle("border-transparent", !active)
      tab.classList.toggle("text-slate-400", !active)
      tab.classList.toggle("font-medium", !active)
    })

    this.panelTargets.forEach((panel) => {
      const active = panel.dataset.panelId === tabId
      panel.classList.toggle("hidden", !active)
    })
  }
}
