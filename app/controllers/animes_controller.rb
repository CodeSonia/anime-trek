class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find(params[:id])
    authorize @anime
    redirect_to animes_path, alert: 'Anime not found' if @anime.nil?
  end

  private

  def anime_params
    params.require(:anime).permit(:id, :title, :synopsis, :date_start, :date_finish, :genre, :rating, :image)
  end
end
