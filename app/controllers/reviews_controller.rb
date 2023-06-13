class ReviewsController < ApplicationController

  def index
    @review = Review.all
  end

  def new
    @anime = Anime.find(params[:anime_id])
    @user = current_user
    @review = Review.new
    authorize @review
  end

  def show
    @anime = Anime.find(params[:id])
    @review = Review.new
    @reviews = Review.where(anime: params[:id]).order(created_at: :desc)
    @avg = (@reviews.map { |review| review.rating }.sum / @reviews.length).to_i unless @reviews.empty?
    @review.anime = @anime
    authorize @anime
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
    authorize @review
    puts @review.inspect

    if @review.save
      redirect_to anime_path(@review.anime), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity, alert: 'Review was not created.'
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
    authorize @review
    @review.destroy
    redirect_to anime_path(@review.anime), notice: 'Review was successfully deleted.'
  end

  private

def review_params
  params.require(:review).permit(:content, :rating, :likes, :user_id, :anime_id)
end
end
