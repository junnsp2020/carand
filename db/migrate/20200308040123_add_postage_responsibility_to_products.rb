class AddPostageResponsibilityToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :postage_responsibility, :integer, default: 0
  end
end
