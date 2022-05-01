import { Controller } from "@hotwired/stimulus"

export default class VisibilityController extends Controller {
  static targets = ["element"]
  static values = { visible: Boolean }

  toggle() {
    this.visibleValue = !this.visibleValue
  }

  show() {
    this.visibleValue = true
  }

  hide() {
    this.visibleValue = false
  }

  visibleValueChanged() {
    this.elementTarget.classList.toggle("hidden", !this.visibleValue)
  }

  hideOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }
}
