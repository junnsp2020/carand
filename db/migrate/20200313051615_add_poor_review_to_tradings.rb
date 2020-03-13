class AddPoorReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :poor_review, :boolean
  end
end
