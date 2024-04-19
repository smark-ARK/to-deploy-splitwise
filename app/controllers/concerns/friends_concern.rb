module FriendsConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    @current_user ||= current_user
  end

  def fetch_friends
    @current_user.friends
  end


  def delete_friend
    friendship = @current_user.friendships.find_by(friend_id: params[:friend_id])
  
    if friendship
      friendship.destroy
      flash[:notice] = "Friend removed successfully."
    else
      flash[:alert] = "This user is not your friend."
    end
  
    redirect_to root_path 
  end
end
