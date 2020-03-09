class Transaction < ApplicationRecord
	belongs_to :user
	belongs_to :product
	enum paymethod:{
    "クレジットカード": 0,
    "コンビニ払い": 1,
  }
  belongs_to :user
  belongs_to :product
end
