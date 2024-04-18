class Expense < ApplicationRecord
    belongs_to :payer, class_name: "User"
    has_many :splits
    accepts_nested_attributes_for :splits

end
