class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def requires_user_signed_in
    redirect_to new_session_url(:redirect_url => request.url) unless user_signed_in? and current_user.is_a?(User)
  end
end
