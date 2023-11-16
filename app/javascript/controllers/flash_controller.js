import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.toastBootstrap = bootstrap.Toast.getOrCreateInstance(this.element)
    this.toastBootstrap.show()
  }
}
