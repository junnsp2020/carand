class RemoveProfitFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :profit, :integer
  end
end
