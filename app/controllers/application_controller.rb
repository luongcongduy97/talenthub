class ApplicationController < ActionController::Base
  include Pundit

  # Originally the application restricted access to only "modern" browsers
  # using `allow_browser versions: :modern`. Some mobile browsers were
  # incorrectly flagged as unsupported, resulting in a 406 Not Acceptable
  # response when navigating via the mobile menu. Commenting out this line
  # prevents those spurious 406 errors.
  # allow_browser versions: :modern

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
