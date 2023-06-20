class WatchlistsController < ApplicationController
  before_action :authenticate_user!

  def add_to_watchlist?
    true
  end

  def create
    @anime = Anime.find(params[:anime_id])
    authorize @anime, :add_to_watchlist?
    @watchlist = current_user.watchlists.build(anime: @anime, status: true)

    if @watchlist.save
      if Watchlist.check_watchlists_increase_points(current_user)
        redirect_to anime_path(@anime), flash[:ua] = { name: UserAchievement.last.achievement.name, desc: UserAchievement.last.achievement.description }
      else
        redirect_to anime_path(@anime), notice: "Anime was successfully added to your watchlist."
      end
    else
      redirect_to anime_path(@anime), status: :unprocessable_entity, alert: "Anime was not added to your watchlist."
    end
  end

  def update
    @watchlist = current_user.watchlists.find(params[:id])

    if @watchlist.update(watchlist_params)
      redirect_to @watchlist.anime, notice: "Anime was successfully updated in your watchlist."
    else
      redirect_to :new, status: :unprocessable_entity, alert: "Anime was not updated in your watchlist."
    end
  end

  def destroy
    @watchlist = current_user.watchlists.find(params[:id])
    authorize @watchlist, :destroy?
    if @watchlist
      @watchlist.destroy
      Watchlist.check_watchlists_decrease_points(current_user)
      redirect_to user_path(current_user), notice: "Anime was successfully removed from your watchlist."
    else
      redirect_to user_path(current_user), status: :unprocessable_entity, alert: "Anime was not removed from your watchlist."
    end
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:status, :notes)
  end
end
