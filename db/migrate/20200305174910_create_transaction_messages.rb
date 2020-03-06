class CreateTransactionMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_messages do |t|

      t.timestamps
    end
  end
end
