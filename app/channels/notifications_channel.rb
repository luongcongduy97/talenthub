class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for current_user
    else
      reject
    end
  end

  def mark_as_read(data)
    notification = current_user.notifications.find(data["id"])
    notification.update!(read_at: Time.current)
  end

  def unsubscribed
  end
end
