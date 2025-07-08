import { Application } from "@hotwired/stimulus"
import MenuController from "./menu_controller"

const application = Application.start()
application.register("menu", MenuController)