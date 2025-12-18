class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for current_user
    else
      reject
    end
  end

  def unsubscribed
  end
end
