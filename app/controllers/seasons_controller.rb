class SeasonsController < ApplicationController
  def index
    @anime = Anime.find(params[:anime_id])
    @seasons = @anime.seasons
  end

  def show
    @anime = Anime.find(params[:anime_id])
    @season = @anime.seasons.find(params[:id])
    redirect_to root_path, alert: 'Season not found' if @season.nil?
  end

  private

  def season_params
    params.require(:season).permit(anime_id, :image, :title, :date_start, :date_finish)
  end
end
