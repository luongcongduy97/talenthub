class ApplicationUpdateJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    UpdateMailer.application_update(user).deliver_now
  end
end
