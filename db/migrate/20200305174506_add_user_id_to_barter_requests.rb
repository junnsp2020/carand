class AddUserIdToBarterRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :barter_requests, :user_id, :integer
    add_column :barter_requests, :product_id, :integer
    add_column :barter_requests, :name, :string
    add_column :barter_requests, :image_id, :string
    add_column :barter_requests, :introduction, :text
  end
end
