module ApplicationCable
  class Channel < ActionCable::Channel::Base
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from StandardError, with: :handle_standard_error

    private

    def handle_not_found(exception)
      Rails.logger.error "ActionCable 404: #{exception.message}"

      transmit({ error: "Resources not found or deleted." })

      reject
    end

    def handle_standard_error(exception)
      Rails.logger.error "ActionCable Error: #{exception.message}"
      if exception.backtrace
        Rails.logger.error exception.backtrace.join("\n")
      end

      transmit({ error: "Something went wrong on the real-time server." })
    end
  end
end
