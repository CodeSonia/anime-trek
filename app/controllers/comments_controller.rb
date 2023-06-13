class CommentsController < ApplicationController
  def create
    @episode = Episode.find(params[:episode_id])
    @user = current_user
    @comment = @episode.comments.build(comment_params)

    if @comment.save
      redirect_to episode_path(@comment.episode_id), notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity, alert: "Comment was not created."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
