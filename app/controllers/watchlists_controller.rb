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
      redirect_to anime_path(@anime), notice: "Anime was successfully added to your watchlist."
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
    if @watchlist
      @watchlist.destroy
      redirect_to @watchlist.anime, notice: "Anime was successfully removed from your watchlist."
    else
      redirect_to @watchlist.anime, status: :unprocessable_entity, alert: "Anime was not removed from your watchlist."
    end
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:status, :notes)
  end
end
