class CommentsController < ApplicationController


  def create
    @dojo = Dojo.find(params[:dojo_id])
    @comment = @dojo.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to dojo_path(@dojo)
  end



  def destroy
    @dojo = Dojo.find(params[:dojo_id])
    @comment = Comment.find(params[:id])

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

  def comment_params
    params.require(:comment).permit(:content)
  end

end
