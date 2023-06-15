class ReviewsController < ApplicationController

  def index
    @review = Review.all
  end

  def edit
    @review = Review.find(params[:id])
    @anime = Anime.find(params[:anime_id])
    authorize @review
  end

  def create
    @anime = Anime.find(params[:anime_id])
    @user = current_user
    @review = Review.new(review_params)
    @review.anime = @anime
    @review.user = @user
    # binding.pry
    authorize @review
    if @review.save
      redirect_to anime_path(@anime), notice: 'Review was successfully created.'
    else
      redirect_to anime_path(@anime), status: :unprocessable_entity, alert: 'Review was not created.'
    end
  end

  def update
    @review = Review.find(params[:id])
    authorize @review

    if @review.update(review_params)
      redirect_to anime_path(@review.anime), notice: 'Review was successfully updated.'
    else
      render :edit, status: :unprocessable_entity, alert: 'Review was not updated.'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.delete
    authorize @review
    redirect_to anime_path(params[:anime_id]), notice: 'Review was successfully deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :user_id, :anime_id)
  end
end
