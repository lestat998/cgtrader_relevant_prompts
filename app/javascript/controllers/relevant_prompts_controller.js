import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["words", "response"];

  connect() {
    console.log("controller connected");
  }

  next(event) {
    event.preventDefault();
    this.queryRelevantPrompts();
    this.clearWordsInput();
  }

  clearList(event) {
    console.log("clear button clicked");
    this.clearResponseContent();
  }

  queryRelevantPrompts() {
    const words = this.wordsTarget.value;
    this.clearResponseContent();
    fetch(`/search_prompts?words=${encodeURIComponent(words)}`)
      .then(response => response.json())
      .then(data => this.updateResponse(data));
  }

  clearWordsInput() {
    this.wordsTarget.value = "";
  }

  clearResponseContent() {
    this.responseTarget.innerHTML = "";
  }

  updateResponse(data) {
    const { query, error } = data;
    console.log(query, error)
    if (error) {
      this.addNoPromptsMessage(error);
    } else if (query.length === 0) {
      this.addNoPromptsMessage('Please try another search.');
    } else {
      query.forEach(prompt => this.addPromptToList(prompt));
    }
  }

  addNoPromptsMessage(error) {
    this.responseTarget.insertAdjacentHTML("beforeend", `<li class="list">
      <span class="prompt">${error}.</span>
    </li>`);
  }

  addPromptToList(prompt) {
    this.responseTarget.insertAdjacentHTML("beforeend", `<li class="list">
      <span class="prompt">${prompt.value}</span>
    </li>`);
  }
}
