class EpisodesController < ApplicationController
  def index
    @anime = Anime.find(params[:anime_id])
    @season = @anime.seasons.find(params[:season_id])
    @episodes = @season.episodes
  end

  def show
    @anime = Anime.find(params[:anime_id])
    @episode = @anime.episodes.includes(:comments).find(params[:id])
    @commentsall = @episode.comments.includes(:user)
    @comment = Comment.new
    authorize @episode
    redirect_to root_path, alert: 'Episode not found' if @episode.nil?
  end

  private

  def episode_params
    params.require(:episode).permit(:season_id, :title, :description, :image, :date_aired, :rating)
  end
end
