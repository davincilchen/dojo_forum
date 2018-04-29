class FriendshipsController < ApplicationController
    def create
      if not current_user.has_friendships?(current_user)
        puts "current +++++"
        @friendship = current_user.friendships.build(friend_id: params[:friend_id])
        @friendship.save
      else
        puts "current ------- "
      end
        redirect_back(fallback_location: root_path)
    end
end
