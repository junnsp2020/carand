class Trading < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  belongs_to :product
  belongs_to :user
  has_many :trading_messages

  enum paymethod:{
  "クレジットカード": 0,
  "コンビニ払い": 1,
  "交換": 2
  }
  enum payment_status:{
   "出品者へ入金報告をする": 0,
   "入金報告をしました。出品者の発送待ちです": 1,
   "受取報告をする": 2,
   "ご利用誠にありがとうございました！": 3
  }
  enum shipment_status:{
   "出荷報告をする": 0,
   "出荷を通知しました。購入者の評価待ちです": 1,
   "購入者を評価する": 2,
   "取引完了": 3
  }

  def total_price
    if product.postage_responsibility == "出品者負担"
    product.price + 0
    else
    product.price + product.postage
    end
  end
end