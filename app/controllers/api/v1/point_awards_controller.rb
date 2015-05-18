class Api::V1::PointAwardsController < Api::V1::BaseController
  before_action :load_posse

  def create
    pa = @posse.point_awards.new(amount: params[:amount])
    if pa.save
      render json: {status: "success", current_score: @posse.current_score}, status: 201
    else
      render json: {status: "failure", errors: pa.errors.full_messages}, status: 422
    end
  end

  def load_posse
    @posse = Posse.find_by(name: params[:posse_name])
    render json: {error: "Posse #{params[:posse_name]} could not be found."}, status: 422 unless @posse
  end
end
