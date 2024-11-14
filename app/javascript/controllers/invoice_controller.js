import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="invoice"
export default class extends Controller {
    delete(event) {
        event.preventDefault();
        if (confirm("Are you sure?")) {
            fetch(this.element.href, {
                method: "DELETE",
                headers: {
                    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                    "Accept": "text/vnd.turbo-stream.html" // Specify Turbo Stream format
                }
            }).then(response => response.text())
                .then(html => {
                    document.body.insertAdjacentHTML("beforeend", html);
                });
        }
    }
}