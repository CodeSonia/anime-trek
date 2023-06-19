class AnimesController < ApplicationController
  def index
    authorize Anime
    @animes = policy_scope(Anime).includes(:episode, :reviews, :users).all
  end

  def show
    @anime = Anime.includes(:episodes, :reviews, :users).find(params[:id])
    @avg = @anime.reviews.average(:rating)
    @pagy, @reviews = pagy(@anime.reviews, items: 2)

    @review = Review.new
    @watchlist = Watchlist.new
    @watchlistadded = current_user.watchlists.find_by(anime_id: @anime.id) if user_signed_in?
    # @new_achievement = current_user.user_achievements.find { |ua| ua.created_at <= Time.now - 1 }
    authorize @anime
    # flash[:ua] = @new_achievement.achievement.name if @new_achievement
    redirect_to animes_path, alert: 'Anime not found' if @anime.nil?
  end

  private

  def search_animes(query)
    Anime.where("title ILIKE ?", "%#{query}%")
  end

  def anime_params
    params.require(:anime).permit(:id, :title, :synopsis, :date_start, :date_finish, :genre, :rating, :image)
  end
end
