import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class DragController extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: ".handle",
      animation: 150,
      onEnd: this.dragHasEnded.bind(this),
    })
  }

  dragHasEnded(event) {
    const csrfToken = document
      .querySelector("[name='csrf-token']")
      .getAttribute("content")
    const data = new FormData()
    data.append("position", event.newIndex + 1)
    fetch(this.urlValue.replace(":id", event.item.dataset.id), {
      method: "PATCH",
      body: data,
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": csrfToken,
        credentials: "same-origin",
        Accept: "text/vnd.turbo-stream.html, text/html, application/xhtml+xml",
      },
    })
  }
}
