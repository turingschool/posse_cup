class StandingsController < ApplicationController
  def index
    @standings = Standings.new.list
  end
end
