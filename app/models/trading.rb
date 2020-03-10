class Trading < ApplicationRecord
   belongs_to :buyer, class_name: "User"
   belongs_to :seller, class_name: "User"
  belongs_to :product

  enum paymethod:{
  "クレジットカード": 0,
  "コンビニ払い": 1,
  }
  enum status:{
  "入金待ち": 0,
  "入金されました　商品を出荷してください": 1,
  "出荷済み":2,
  "受け取りました": 3
  }

  def total_price
  	if product.postage_responsibility == "出品者負担"
  	product.price + 0
  	else
  	product.price + product.postage
  	end
  end
end
