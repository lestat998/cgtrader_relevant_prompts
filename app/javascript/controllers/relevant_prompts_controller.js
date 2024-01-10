import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["words", "response"];

  connect() {
    console.log("controller connected");
  }

  next(event) {
    event.preventDefault();
    this.queryRelevantPrompts();
    this.wordsTarget.value = "";
  }

  clearList(event) {
    console.log("clear button clicked");
    this.responseTarget.innerHTML = "";
  }

  queryRelevantPrompts() {
    const words = this.wordsTarget.value;
    fetch(`/search_prompts?words=${encodeURIComponent(words)}`)
        .then(response => response.json()).then(data => {
            const { prompts } = data;
            if (prompts.length === 0) {
                this.responseTarget.insertAdjacentHTML("beforeend", ` <li class="list"">
              <span class="prompt">You have no relevant prompts.</span>
            </li>`);
            } else {
                prompts.forEach(prompt => {
                  this.responseTarget.insertAdjacentHTML("beforeend", ` <li class="list"">
              <span class="prompt">${prompt}</span>
            </li>`);
                });
            }
    })
  }
}