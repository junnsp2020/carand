class AddMessageToTransactionMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_messages, :message, :text
  end
end
