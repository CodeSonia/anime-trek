class SeasonsController < ApplicationController
  def index
    @seasons = Season.all
  end

  def show
    @season = Season.find(params[:id])
    redirect_to root_path, alert: 'Season not found' if @season.nil?
  end

  private

  def season_params
    params.require(:season).permit(anime_id, :image, :title, :date_start, :date_finish)
  end
end
