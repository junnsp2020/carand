class AddBuyerIdToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :buyer_id, :integer
  end
end
