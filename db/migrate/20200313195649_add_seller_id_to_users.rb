class AddSellerIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :seller_id, :integer
  end
end
