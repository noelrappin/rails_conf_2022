import { Controller } from "@hotwired/stimulus"

export default class AutosubmitController extends Controller {
  static targets = ["form"]

  initialize() {
    super.initialize()
    this.debounceMethodName("submit", 1000)
  }

  debounceMethodName(methodName, wait = 300) {
    this[methodName] = debounce(this[methodName].bind(this), wait)
  }

  setFocusBorder(element, newBorderColor) {
    const focusBorders = Array.from(element.classList).filter((className) => {
      return className.startsWith("focus:border")
    })
    focusBorders.forEach((border) => element.classList.remove(border))
    element.classList.add(newBorderColor)
  }

  typingStarted(event) {
    this.setFocusBorder(event.target, "focus:border-orange-700")
  }

  async submit(event) {
    this.formTarget.requestSubmit()
    this.setFocusBorder(event.target, "focus:border-green-500")
  }
}

function debounce(fn, delay = 10) {
  let timeoutId = null

  return (...args) => {
    const callback = () => fn.apply(this, args)
    clearTimeout(timeoutId)
    timeoutId = setTimeout(callback, delay)
  }
}
