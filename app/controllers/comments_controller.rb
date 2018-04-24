class CommentsController < ApplicationController


  def create
    @dojo = Dojo.find(params[:dojo_id])
    @comment = @dojo.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to dojo_path(@dojo)
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
