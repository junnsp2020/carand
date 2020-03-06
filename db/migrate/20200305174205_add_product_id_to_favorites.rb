class AddProductIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :product_id, :integer
  end
end
