class AddProprietyToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :propriety, :integer, default: 0
  end
end
