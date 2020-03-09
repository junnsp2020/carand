class CreateTradingMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :trading_messages do |t|

      t.timestamps
    end
  end
end
