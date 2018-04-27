class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_dojo, only: [:create, :update, :destroy]

  def create
    @comment = @dojo.comments.build(comment_params)
    @comment.user = current_user
    if not @comment.save
      flash[:alert] = @comment.errors.full_messages.to_sentence
    end
    redirect_to dojo_path(@dojo)
  end


  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment was successfully updated"
    else
      flash[:alert] = "Fail to update comment "
    end
    redirect_to dojo_path(@dojo)
  end

  def destroy
    if @comment
      if @comment.user == current_user
        @comment.destroy
        flash[:alert] = "Comment was deleted"
      else
        flash[:alert] = "Current user is not user of the comment"
      end
    else
      flash[:alert] = "Fail to delete comment"
    end
    redirect_to dojo_path(@dojo)
  end


  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_dojo
    @dojo = Dojo.find(params[:dojo_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
