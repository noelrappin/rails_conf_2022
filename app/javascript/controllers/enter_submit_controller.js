import { Controller } from "@hotwired/stimulus"

export default class EnterSubmitController extends Controller {
  static targets = ["form", "field"]

  // Automatically connecting the event rather than forcing the
  // field target to explicitly declare an event that it would have to
  // declare 100% of the time to make this work
  connect() {
    if (this.hasFieldTarget) {
      this.fieldTarget.addEventListener("keydown", (event) => {
        this.keyDown(event, this.fieldTarget)
      })
    }
  }

  // This is a keydown event because it needs to be a keydown event to
  // prevent the browser from implicitly submitting the form on enter.
  // (keyup is too late)
  // We don't want the browser to implicitly submit (even though this code
  // just submits anyway), because the implicit submission caused a weird
  // cypress test error, and in any case, I'd rather be in control of the
  // submission in case this form ever changes
  keyDown(event, field) {
    if (event.keyCode === 13) {
      event.preventDefault()
      event.stopPropagation()
      this.formTarget.requestSubmit()
      field.value = ""
      field.focus()
      return false
    }
  }
}
