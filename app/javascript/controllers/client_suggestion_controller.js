import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="client-suggestion"
export default class extends Controller {
    static targets = ["input", "suggestions", "select"]

    connect() {
        this.inputTarget.addEventListener("input", this.fetchClients.bind(this))
    }

    fetchClients() {
        const query = this.inputTarget.value;

        // Clear selectTarget if the input is not yet sufficient for a suggestion
        if (query.length <= 2) {
            this.suggestionsTarget.innerHTML = ''; // Clear suggestions
            this.selectTarget.value = ''; // Clear client_id field
            return;
        }

        fetch(`/clients?name=${query}`)
            .then(response => response.json())
            .then(data => {
                this.suggestionsTarget.innerHTML = '';
                data.forEach(client => {
                    const div = document.createElement('div');
                    div.textContent = client.name;
                    div.onclick = () => {
                        this.inputTarget.value = client.name;
                        this.selectTarget.value = client.id; // Set the hidden client_id field
                        this.suggestionsTarget.innerHTML = ''; // Clear suggestions
                    };
                    this.suggestionsTarget.appendChild(div);
                });

                // Clear client_id field if input name doesn't match any suggestion
                if (!data.some(client => client.name === query)) {
                    this.selectTarget.value = ''; // Clear client_id field
                }
            });
    }
}