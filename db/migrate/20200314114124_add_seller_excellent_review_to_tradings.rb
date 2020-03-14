class AddSellerExcellentReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :seller_excellent_review, :boolean
  end
end
