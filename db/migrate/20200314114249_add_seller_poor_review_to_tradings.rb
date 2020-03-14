class AddSellerPoorReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :seller_poor_review, :boolean
  end
end
