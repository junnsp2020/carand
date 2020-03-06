class AddTransactionIdToTransactionMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_messages, :transaction_id, :integer
  end
end
