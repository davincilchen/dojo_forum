class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    current_user.create_friendships(@user)
    redirect_back(fallback_location: root_path)
  end


  def accept
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:id])
    @friendship.update(accepted: true)
    redirect_back(fallback_location: root_path)
  end

  def ignore
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end
