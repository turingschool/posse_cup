class Api::V1::CommandsController < Api::V1::BaseController
  def create
    render CommandType.new(params[:text], params.slice(:token, :uid)).response
  end
end
