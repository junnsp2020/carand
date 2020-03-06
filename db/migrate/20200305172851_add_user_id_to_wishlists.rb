class AddUserIdToWishlists < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlists, :user_id, :integer
  end
end
