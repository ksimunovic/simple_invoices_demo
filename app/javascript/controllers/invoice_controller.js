import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="invoice"
export default class extends Controller {
    static targets = ["form", "invoices"]

    delete(event) {
        event.preventDefault();
        if (confirm("Are you sure?")) {
            fetch(this.element.href, {
                method: "DELETE",
                headers: {
                    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                    "Accept": "text/vnd.turbo-stream.html"
                }
            }).then(response => {
                if (!response.ok) {
                    throw new Error("Server error: " + response.status);
                }
                return response.text();
            }).then(html => {
                document.body.insertAdjacentHTML("beforeend", html);
            }).catch(error => {
                alert(error.message);
            });
        }
    }

    edit(event) {
        event.preventDefault();
        const invoiceId = event.currentTarget.dataset.invoiceId;
        fetch(`/invoices/${invoiceId}/edit`, {
            headers: {
                "Accept": "text/vnd.turbo-stream.html"
            }
        }).then(response => {
            if (!response.ok) {
                throw new Error("Server error: " + response.status);
            }
            return response.text();
        }).then(html => {
            document.body.insertAdjacentHTML("beforeend", html);
        }).catch(error => {
            alert(error.message);
        });
    }
}