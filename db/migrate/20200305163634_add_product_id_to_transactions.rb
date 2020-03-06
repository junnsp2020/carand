class AddProductIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :product_id, :integer
    add_column :transactions, :status, :integer
    add_column :transactions, :profit, :integer
    add_column :transactions, :paymethod, :integer
    add_column :transactions, :postage, :integer
    add_column :transactions, :price, :integer
  end
end
