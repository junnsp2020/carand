class AddPaymethodToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :paymethod, :integer, default: 0
  end
end
