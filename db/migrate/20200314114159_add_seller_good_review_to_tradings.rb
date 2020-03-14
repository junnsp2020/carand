class AddSellerGoodReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :seller_good_review, :boolean
  end
end
