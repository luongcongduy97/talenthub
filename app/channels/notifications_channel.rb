class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for current_user
    else
      reject
    end
  end

  def mark_as_read(data)
    current_user.notifications.find(data["id"]).update!(read_at: Time.current)
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read_at: Time.current)
  end

  def unsubscribed
  end
end
