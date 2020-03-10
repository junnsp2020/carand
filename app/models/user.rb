class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image
  has_many :products
  has_many :active_tradings, class_name: "Trading", foreign_key: :buyer_id
  has_many :buyers, through: :active_relationships, source: :seller
  has_many :passive_tradings, class_name: "Trading", foreign_key: :seller_id
  has_many :sellers, through: :passive_relationships, source: :buyer
end
