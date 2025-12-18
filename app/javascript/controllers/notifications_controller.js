import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

console.log("File JS Notifications đã được tải!")

export default class extends Controller {
  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel"},
      {
        connected: () => {
          console.log("Đã kết nối Notifications!")
        },

        disconnected: () => {
          console.log("Mất kết nối Notifications!")
        },

        received: (data) => {
          console.log("Nhận được tin nhắn:", data)
          alert(data.message)
        }
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }
}