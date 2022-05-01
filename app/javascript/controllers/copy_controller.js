import { Controller } from "@hotwired/stimulus"

export default class CopyController extends Controller {
  static targets = ["to"]

  copy(event) {
    this.toTarget.value = event.target.dataset.copyText
  }
}
