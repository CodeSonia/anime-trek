class PagesController < ApplicationController
  skip_before_action :configure_permitted_parameters, only: [:home]

  def home
    @animes = Anime.all
  end
end
