class RemoveTotalPriceFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :total_price, :integer
  end
end
