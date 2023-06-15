class CommentsController < ApplicationController
  def create
    @episode = Episode.find(params[:episode_id])
    @user = current_user
    @comment = @episode.comments.build(comment_params)
    @comment.episode = @episode
    @comment.user = @user
    authorize @comment
    if @comment.save
      redirect_to anime_episode_path(@episode.anime, @episode), notice: "Comment was successfully created."
    else
      redirect_to anime_episode_path(@episode.anime, @episode), status: :unprocessable_entity, alert: "Comment was not created."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    authorize @comment
    redirect_to anime_episode_path(@comment.episode.anime, @comment.episode), notice: "Comment was deleted successfully"
  end
  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
