import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "button"]
  connect() {
    console.log("connect")
    this.buttonTarget.addEventListener('click', (event) => {
      event.preventDefault();
      console.log("click", event);

      if (this.inputTarget.value === "") {
        this.listTarget.innerHTML = "We couldn't find any anime matching your search criteria. Could you please provide the name of the anime again?";
      } else {
        console.log(event)
        this.updateList();
        this.inputTarget.value = "";
      }
    });
  }

  update(event) {
    event.preventDefault();
    console.log("test", event);
    console.log("list", this.formTarget.value);
    this.updateList();
  }

  updateList(event) {
    console.log("list", this.inputTarget.value);
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    if(event.keyCode !== 13) {
      fetch(url, { method: "get", headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        console.log("data");
        this.listTarget.outerHTML = data;
      });
    } else {
      this.inputTarget.value = "";
    }

  }
}
