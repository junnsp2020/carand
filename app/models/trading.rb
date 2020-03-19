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
   "受取報告をする": 1,
   "ご利用誠にありがとうございました！": 2
  }
  # enum shipment_status:{
  #  "入金待ち": 0,
  #  "出荷報告をする": 1,
  #  "購入者を評価をする": 2
  # }
  enum shipment_status:{
   "出荷報告をする": 0,
   "購入者を評価する": 1
  }

  def change_payment_status!
    if 出品者へ入金報告をする?
      受取報告をする!
    else
      ご利用誠にありがとうございました！!
    end
  end

  def change_shipment_status!
  if 出荷報告をする?
   購入者を評価する!
  else
   購入者を評価をする!
  end
  end

  def total_price
    if product.postage_responsibility == "出品者負担"
    product.price + 0
    else
    product.price + product.postage
    end
  end
end