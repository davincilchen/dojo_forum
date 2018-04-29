class FriendshipsController < ApplicationController
    def create
      @user = User.find(params[:friend_id])
      current_user.create_friendships(@user)
      redirect_back(fallback_location: root_path)
    end
end
