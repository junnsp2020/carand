class AddBuyerIdToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :buyer_id, :integer
  end
end
