class AddTotalPriceToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :total_price, :integer
  end
end
