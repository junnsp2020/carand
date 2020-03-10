class Product < ApplicationRecord
	attachment :image

	def postage
		postage = 1000
	end

	enum status:{
    "新品・未使用": 0,
    "未使用に近い": 1,
    "目立った傷や汚れ無し": 2,
    "傷や汚れあり": 3,
    "全体的に状態が悪い": 4
  }

	enum postage_responsibility:{
    "出品者負担": 0,
    "購入者負担": 1
  }
  enum sale_status:{
    "販売中": 0,
    "売り切れ": 1,
  }
  has_many :tradings
  # belongs_to :buyer, class_name: "User"
  # belongs_to :seller, class_name: "User"
  belongs_to :user
end
