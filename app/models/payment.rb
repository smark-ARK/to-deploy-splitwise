class Payment < ApplicationRecord
    enum method: [:cash, :online]
    belongs_to :from_user, class_name: 'User'
    belongs_to :to_user, class_name: 'User'

    after_create :update_balance

    def update_balance
        @friendship = Friendship.find_by(user_id: from_user_id, friend_id: to_user_id)
            @friendship.balance += amount
            @friendship.save()
            
            @friendship = Friendship.find_by(user_id: to_user_id, friend_id: from_user_id)
            @friendship.balance -= amount
            @friendship.save()
    end
    
end
