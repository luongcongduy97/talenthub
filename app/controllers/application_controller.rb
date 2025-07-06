class ApplicationController < ActionController::Base
  include Pundit

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end


  # After signing in or signing up, redirect users to their profile instead of
  # the admin-only root path to avoid redirect loops for non-admins.
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  alias_method :after_sign_up_path_for, :after_sign_in_path_for
end
