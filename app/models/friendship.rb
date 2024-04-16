class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :create_inverse, unless: :inverse_exists?
  after_destroy :delete_inverse, unless: :inverse_exists?

  def create_inverse
    self.class.create(inverse_friendship_options)
  end

  def delete_inverse
    self.class.find_by(inverse_friendship_options).destroy
  end
  def inverse_exists?
    self.class.exists?(inverse_friendship_options)
  end

  def inverse_friendship_options
    { friend_id: user_id, user_id: friend_id }
  end
  
end
