class AddCategoryIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :category_id, :integer
    add_column :products, :user_id, :integer
    add_column :products, :name, :string
    add_column :products, :image_id, :string
    add_column :products, :introduction, :text
    add_column :products, :status, :integer
    add_column :products, :price, :integer
  end
end
