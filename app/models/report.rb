class Report < ApplicationRecord
	enum subject:{
    "偽造品・レプリカ商品": 0,
    "公序良俗に反する商品": 1,
    "知的財産権(著作権・商標権など)侵害商品": 2,
    "その他法令違反": 3
  }
  belongs_to :user
  belongs_to :product
end
