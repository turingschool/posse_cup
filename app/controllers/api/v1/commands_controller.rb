class Api::V1::CommandsController < Api::V1::BaseController
  def create
    render Commands.parse(params[:text], params.slice(:token, :user_id)).response.symbolize_keys
  end
end
