class EpisodesController < ApplicationController
  def index
    @anime = Anime.find_by(slug: params[:anime_id])
    @episode = @episodes.includes(:comments).find(params[:id])

  end

  def show
    @episode = Episode.find(params[:id])
    @anime = @episode.anime
    @pagy, @commentsall = pagy(@episode.comments.includes(:user), items: 2)
    @comment = Comment.new
    authorize @episode
    redirect_to root_path, alert: 'Episode not found' if @episode.nil?
  end

  private

  def episode_params
    params.require(:episode).permit(:season_id, :title, :description, :image, :date_aired, :rating)
  end
end
