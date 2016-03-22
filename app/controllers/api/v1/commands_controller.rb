class Api::V1::CommandsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def create
    render {json: {text: "RIP IN PIECES POSSE CUP" }, status: 200}
    # render Commands.parse(params[:text], params.slice(:token, :user_id)).response.symbolize_keys
  end
end
