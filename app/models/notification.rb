class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read_at: nil) }
  default_scope { order(created_at: :desc) }

  after_create_commit :broadcast_notification

  private

  def broadcast_notification
    NotificationsChannel.broadcast_to(
      self.user,
      {
        message: self.message,
        url: self.url
      }
    )
  end
end
