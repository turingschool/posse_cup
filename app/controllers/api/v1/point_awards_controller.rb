class Api::V1::PointAwardsController < Api::V1::BaseController
  before_action :log_info, :require_token, :require_admin, :load_posse, :validate_amount

  def log_info
    10.times { Rails.logger.info("*************************")}
    Rails.logger.info("Got award req with params #{params}")
    Rails.logger.info("Got award req with headers #{request.headers}")
    10.times { Rails.logger.info("*************************")}
  end

  def create
    pa = @posse.point_awards.new(amount: @amount)
    if pa.save
      render json: {status: "success", current_score: @posse.current_score, text: success_message}, status: 200
    else
      render json: {status: "failure", errors: pa.errors.full_messages}, status: 422
    end
  end

  def success_message
    "#{@amount} points awarded to #{@posse.name} posse! Current score: #{@posse.current_score}."
  end

  def load_posse
    pname = (params[:text].to_s.match(/to (.*$)/) || [])[1]
    if pname.nil?
      render json: {text: "Error: No posse name provided, please use format '30 points to Staff'."}
    elsif (@posse = Posse.find_by(name: pname)).nil?
      render json: {text: "Posse #{pname} could not be found."}
    end
  end

  def validate_amount
    @amount = params[:text].split[1].to_i
    if @amount == 0
      render json: {text: "Sorry, that amount isn't valid. Please use format '#PC 30 points to Staff'"}, status: 200
    end
  end

  def require_admin
    render json: {error: "User not authorized."}, status: 401 unless admin_uids.include?(params[:user_id])
  end

  def admin_uids
    {"U02MYKGQB" => "Horace"}.keys
  end
end
