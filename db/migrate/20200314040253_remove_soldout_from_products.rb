class RemoveSoldoutFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :soldout, :boolean
  end
end
