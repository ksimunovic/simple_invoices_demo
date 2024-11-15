// controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["message"];

    connect() {
        if (this.hasMessageTarget) {
            setTimeout(() => {
                this.messageTarget.closest('.flash-message').remove();
            }, 5000);
        }
    }

    close(event) {
        const messageElement = event.target.closest('.flash-message');
        if (messageElement) {
            messageElement.remove();
        }
    }
}