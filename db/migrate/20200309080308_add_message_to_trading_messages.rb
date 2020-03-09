class AddMessageToTradingMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :trading_messages, :message, :text
  end
end
