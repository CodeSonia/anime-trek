class CommentsController < ApplicationController
  def index
    @episode = Episode.find(params[:episode_id])
    @pagy, @comments = pagy(policy_scope(@episode.comments), items: 2)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "comments/comments", locals: {comments: @comments}, formats: [:html] }
    end
  end

  def create
    @episode = Episode.find(params[:episode_id])
    @user = current_user
    @comment = @episode.comments.build(comment_params)
    @comment.episode = @episode
    @comment.user = @user
    authorize @comment
    if @comment.save
      if Comment.check_comments_increase_points(current_user)
        redirect_to episode_path(@episode), flash[:ua] = { name: UserAchievement.last.achievement.name, desc: UserAchievement.last.achievement.description }
      else
        redirect_to episode_path(@episode), notice: "Comment was successfully created."
      end
    else
      redirect_to episode_path(@episode), status: :unprocessable_entity, alert: "Comment was not created."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    Comment.check_comments_decrease_points(current_user)
    authorize @comment
    redirect_to episode_path(@comment.episode), notice: "Comment was deleted successfully"
  end
  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
