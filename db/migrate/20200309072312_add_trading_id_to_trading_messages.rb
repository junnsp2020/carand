class AddTradingIdToTradingMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :trading_messages, :trading_id, :integer
  end
end
