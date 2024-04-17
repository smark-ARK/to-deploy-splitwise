class Split < ApplicationRecord
    belongs_to :expense
    belongs_to :participant, class_name: "User"
end
