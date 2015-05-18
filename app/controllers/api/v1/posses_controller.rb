class Api::V1::PossesController < Api::V1::BaseController
  def index
    render json: Posse.all
  end
end
