import { Controller } from "@hotwired/stimulus"

export default class RotatingController extends Controller {
  static targets = ["button"]
  static values = { isInitiallyDown: Boolean, isCurrentlyDown: Boolean }

  toggle() {
    this.isCurrentlyDownValue = !this.isCurrentlyDownValue
  }

  isInitiallyDownValueChanged() {
    this.buttonTarget.classList.add(
      this.isInitiallyDownValue ? "chevron-down" : "chevron-up"
    )
  }

  isCurrentlyDownValueChanged() {
    this.buttonTarget.classList.toggle(
      "rotate-180",
      this.isCurrentlyDownValue !== this.isInitiallyDownValue
    )
  }
}
