class AddSellerIdToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :seller_id, :integer
  end
end
