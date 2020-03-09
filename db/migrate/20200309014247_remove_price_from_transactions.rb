class RemovePriceFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :price, :integer
  end
end
