class ReviewsController < ApplicationController
  def create
    @anime = Anime.find(params[:anime_id])
    @user = current_user
    @review = Review.new(review_params)

    if @review.save
      redirect_to anime_path(@review.anime), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity, alert: 'Review was not created.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :likes, :user_id, :anime_id)
  end
end
