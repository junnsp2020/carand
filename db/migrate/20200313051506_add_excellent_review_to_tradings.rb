class AddExcellentReviewToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :excellent_review, :boolean
  end
end
