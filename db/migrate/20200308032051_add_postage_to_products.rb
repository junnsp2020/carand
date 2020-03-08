class AddPostageToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :postage, :integer
  end
end
