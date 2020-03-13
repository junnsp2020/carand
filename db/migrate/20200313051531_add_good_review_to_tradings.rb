class AddGoodReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :good_review, :boolean
  end
end
