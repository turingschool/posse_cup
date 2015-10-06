class SessionsController < ApplicationController
  before_action :bounce_logged_in

  def new
  end

  def create
    session["user_info"] = request.env["omniauth.auth"]["info"].to_json
    redirect_to :root
  end

  def destroy
    reset_session
    redirect_to :root
  end

  def bounce_logged_in
    redirect_to :root if logged_in?
  end
end
