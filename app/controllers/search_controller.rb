class SearchController < ApplicationController
  def index
    @animes = policy_scope(Anime).all
    if params[:query].present?
      @animes = @animes.where("title ILIKE :query OR genre ILIKE :query", query: "%#{params[:query]}%")
    end
    respond_to do |format|
      format.html # when you push the enter button or refresh
      format.text { render partial: "shared/list", locals: { animes: @animes }, formats: [:html] }
      # ^ when you do the request through fetch
    end
  end

  private

  def perform_search(query)
    Anime.where("title ILIKE :query OR genre ILIKE :query", query: "%#{query}%")
  end
end
