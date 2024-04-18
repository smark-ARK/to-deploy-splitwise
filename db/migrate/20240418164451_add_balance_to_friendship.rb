class AddBalanceToFriendship < ActiveRecord::Migration[6.1]
  def change
    add_column :friendships, :balance, :decimal, default: 0, null: false
  end
end
