class AddNoticeToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :notice, :boolean
  end
end
