class Api::V1::BaseController < ApplicationController
  def require_token
    render json: {error: "Invalid Token"}, status: 401 unless params["token"] == ENV["SLACK_AUTH_TOKEN"]
  end
end
