class AddSoldoutToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :soldout, :boolean, default: false
  end
end
