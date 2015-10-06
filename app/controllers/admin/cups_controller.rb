class Admin::CupsController < Admin::BaseController
  def new
  end

  def create
    Cup.declare_victor!
    redirect_to cups_path
  end
end
