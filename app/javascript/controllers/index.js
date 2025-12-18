import { Application } from "@hotwired/stimulus"
import MenuController from "./menu_controller"
import NotificationsController from "./notifications_controller"

const application = Application.start()
application.register("menu", MenuController)
application.register("notifications", NotificationsController)