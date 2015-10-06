class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= JSON.parse(session["user_info"]) if session["user_info"]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    logged_in? && Auth.admin?(current_user["user_id"])
  end

  helper_method :current_user, :logged_in?, :admin?
end
