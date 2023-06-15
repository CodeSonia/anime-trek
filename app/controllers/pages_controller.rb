class PagesController < ApplicationController
  skip_before_action :configure_permitted_parameters, only: [:home, :index]

  def index
    # Logic to process the search query and retrieve the results
    @results = perform_search(params[:query])

  end

  def home
    @animes = Anime.all
  end
end
