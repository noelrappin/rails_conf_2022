import { Controller } from "@hotwired/stimulus"
// import "form-request-submit-polyfill"

export default class FormController extends Controller {
  static targets = ["form"]

  submit() {
    this.formTarget.requestSubmit()
  }
}
