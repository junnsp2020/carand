class AddUserIdToTradingMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :trading_messages, :user_id, :integer
  end
end
