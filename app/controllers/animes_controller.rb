class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find(params[:id])
    redirect_to root_path, alert: 'Anime not found' if @anime.nil?
  end
end
