import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

console.log("File JS Notifications đã được tải!")

export default class extends Controller {
  static targets = ["container", "dropdown", "badge", "list"]
  connect() {
    createConsumer().subscriptions.create("NotificationsChannel", {
      received: (data) => {
        this.displayToast(data.message)
        this.updateBadge()
        this.prependToList(data)
      }
    })
  }

  toggle(event) {
    event.preventDefault()
    this.dropdownTarget.classList.toggle("hidden")
  }

  displayToast(message) {
    const toastHtml = `
      <div class="transform transition-all duration-300 ease-out translate-x-full opacity-0 flex items-center w-full max-w-xs p-4 mb-3 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800" role="alert">
        <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-blue-500 bg-blue-100 rounded-lg dark:bg-blue-800 dark:text-blue-200">
          <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
            <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>
          </svg>
        </div>
        <div class="ms-3 text-sm font-normal">${message}</div>
        <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" aria-label="Close" onclick="this.parentElement.remove()">
          <span class="sr-only">Close</span>
          <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
          </svg>
        </button>
      </div>
    `

    this.containerTarget.insertAdjacentHTML("beforeend", toastHtml)
    const toastElement = this.containerTarget.lastElementChild

    setTimeout(() => {
      toastElement.classList.remove('translate-x-full', 'opacity-0')
    }, 10)

    setTimeout(() => {
      toastElement.classList.add('opacity-0', 'translate-x-full')

      setTimeout(() => {
        toastElement.remove()
      }, 300)
    }, 4000)
  }

  updateBadge() {
    if (this.hasBadgeTarget) {
      this.badgeTarget.classList.remove("hidden")
    }
  }

  prependToList(data) {
    if (this.hasListTarget) {
      const html = `
        <a class="block px-4 py-3 hover:bg-gray-50 transition duration-150 ease-in-out bg-blue-50" href="${data.url}">
          <div class="flex items-start">
            <div class="flex-shrink-0">
              <span class="inline-flex items-center justify-center h-8 w-8 rounded-full bg-blue-500>
                <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24 stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </span>
            </div>
            <div class="ml-3 w-0 flex-1">
              <p class="text-sm font-medium text-gray-900">${data.message}</p>
              <p class="text-xs text-gray-500 mt-1">Vừa xong</p>
            </div>
          </div>
        </a>
      `
      this.listTarget.insertAdjacentHTML("afterbegin", html)
    }
  }
}