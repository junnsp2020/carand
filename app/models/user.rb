class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum is_deleted:{
    "有効": false,
    "無効": true
  }
  def active_for_authentication?
      super && self.is_deleted != "無効"
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :products
  has_many :active_tradings, class_name: "Trading", foreign_key: :buyer_id
  has_many :buyers, through: :active_relationships, source: :seller
  has_many :passive_tradings, class_name: "Trading", foreign_key: :seller_id
  has_many :sellers, through: :passive_relationships, source: :buyer
  has_many :barter_requests
  has_many :favorites, dependent: :destroy
  has_many :tradings
  has_many :reports
  has_many :wishlists
  has_many :trading_messages
  has_many :product_comments

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :nickname, presence: true
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :phone_number, presence: true
end
