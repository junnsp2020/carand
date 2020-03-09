class RemovePaymethodFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :paymethod, :integer
  end
end
