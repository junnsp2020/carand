class AddProductIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :product_id, :integer
  end
end
