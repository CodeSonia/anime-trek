class AnimesController < ApplicationController
  def index
    authorize Anime
    @animes = policy_scope(Anime).includes(:episode, :reviews, :users).all
  end

  def show
    @anime = Anime.includes(:episodes, :reviews, :users).find(params[:id])
    @avg = @anime.reviews.average(:rating)
    authorize @anime
    redirect_to animes_path, alert: 'Anime not found' if @anime.nil?
  end

  private

  def anime_params
    params.require(:anime).permit(:id, :title, :synopsis, :date_start, :date_finish, :genre, :rating, :image)
  end
end
