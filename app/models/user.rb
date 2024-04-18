class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :expenses, foreign_key: :payer_id
  has_many :splits, foreign_key: :participant_id
  has_many :payments, foreign_key: :from_user_id
  has_many :payments, foreign_key: :to_user_id
end
