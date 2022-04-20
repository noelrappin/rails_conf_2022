import { Controller } from "@hotwired/stimulus"

export default class VisibilityController extends Controller {
  static targets = ["element"]
  static values = { visible: Boolean }

  toggle() {
    this.visibleValue = !this.visibleValue
  }

  visibleValueChanged() {
    this.elementTarget.classList.toggle("hidden", !this.visibleValue)
  }
}
