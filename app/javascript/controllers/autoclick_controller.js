import { Controller } from "@hotwired/stimulus"
import { useIntersection } from 'stimulus-use'

// Connects to data-controller="autoclick"
export default class extends Controller {

  static values = { pageNumber: Number,
                    episodeId: Number}
  static targets = ["moreComments", "stopLoading"]

  options = {
    threshold: 1,
    element: this.stopLoadingTarget
  }

  connect() {
    useIntersection(this, this.options)
  }

  appear(entry) {
    this.pageNumberValue = this.pageNumberValue + 1
    const url = `/episodes/${this.episodeIdValue}/comments?page=${this.pageNumberValue}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then(data => this.moreCommentsTarget.insertAdjacentHTML('beforeend', data))


    // this.element.click()
  }
}
