class RemoveSoldoutFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :soldout, :boolean
  end
end
