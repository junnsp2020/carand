class AddSellerIdToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :seller_id, :integer
  end
end
