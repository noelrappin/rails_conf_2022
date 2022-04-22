import { Controller } from "@hotwired/stimulus"

export default class PulldownController extends Controller {
  static classes = ["active"]
  static targets = ["list", "entry", "field", "display"]
  static values = { selected: String, status: String }

  open() {
    this.statusValue = "open"
  }

  close() {
    this.statusValue = "closed"
  }

  isOpen() {
    return this.statusValue === "open"
  }

  statusValueChanged() {
    this.listTarget.classList.toggle("hidden", !this.isOpen())
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  select(event) {
    this.fieldTarget.value = event.target.dataset.value
    this.setActiveItem(event.target.dataset.value)
    this.displayTarget.innerText = " ... "
    this.close()
  }

  setActiveItem(value) {
    this.entryTargets.forEach((target) => {
      target.classList.toggle(this.activeClass, target.dataset.value === value)
    })
  }
}
