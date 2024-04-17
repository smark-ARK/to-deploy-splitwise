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

  def add_friend(friend_email)
    friend = User.find_by(email: friend_email)
    return unless friend.present? && friend != @current_user

    @current_user.friendships.create(friend: friend)
  end

  def remove_friend(friend_id)
    friendship = @current_user.friendships.find_by(friend_id: friend_id)
    return unless friendship.present?

    friendship.destroy
  end
end
