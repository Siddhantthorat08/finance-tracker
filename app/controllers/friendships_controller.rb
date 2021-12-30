class FriendshipsController < ApplicationController
 
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "You starred following #{friend.full_name}"
      redirect_to friends_path
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "stopped following"
    redirect_to friends_path
  end
end
