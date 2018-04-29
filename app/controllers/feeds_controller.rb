class FeedsController < ApplicationController
  def index
    @user_count = User.all.count
    @dojo_count = Dojo.public_post.count
    @comment_count = Comment.all.count
    @users = User.select(:id, :name, :comments_count).order(comments_count: :desc).limit(10)
    @dojos = Dojo.select(:id, :title, :comments_count, :updated_at).order(comments_count: :desc).limit(10)
  end  
end
