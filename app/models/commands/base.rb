class Commands::Base
  attr_reader :text, :options
  def initialize(text, options = {})
    @text = text
    @options = ActiveSupport::HashWithIndifferentAccess.new(options)
  end

  def response
    {}
  end

  def uid
    options["user_id"]
  end

  def admin?
    uid.present? && admins.keys.include?(uid)
  end

  def token_valid?
    options["token"] == ENV["SLACK_AUTH_TOKEN"]
  end

  def admins
    {"U02MYKGQB" => "Horace", "U02H7KFLL" => "Raissa", "U02D2TTKD" => "Rachel", "U029P2S9P" => "Jeff C",
     "U02GA9USU" => "Steve", "U02C40LBY" => "Josh M.", "U03P5UB9G" => "Daisha", "U02Q25H6V" => "Mike",
     "U029PR5TG" => "Jorge", "U0416PCQ3" => "Sam"}
  end
end
