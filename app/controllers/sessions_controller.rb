class SessionsController < ApplicationController
  def new
  end

  def create
    Rails.logger.info(request.env["omniauth.auth"].inspect)
  end
end
