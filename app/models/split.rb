class Split < ApplicationRecord
    belongs_to :expense
    belongs_to :participant, class_name: "User"

    after_create :update_balance

    def update_balance
        if expense.payer_id != participant_id
            @friendship = Friendship.find_by(user_id: expense.payer_id, friend_id: participant_id)
            @friendship.balance += amount
            @friendship.save()
            
            @friendship = Friendship.find_by(user_id: participant_id, friend_id: expense.payer_id)
            @friendship.balance -= amount
            @friendship.save()
        end
        
    end

end
