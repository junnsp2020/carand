class AddBuyerIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :buyer_id, :integer
  end
end
