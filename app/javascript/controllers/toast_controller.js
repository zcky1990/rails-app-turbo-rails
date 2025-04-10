import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ["toastId" ];

  connect() {
    setTimeout(() => {
      this.element.style.transition = "opacity 0.5s ease-out";
      this.element.style.display = "none";
      // setTimeout(() => this.element.remove(), 500);
    }, 5000);
  }

  close() {
    this.toastIdTarget.style.display = "none";
  }

}
