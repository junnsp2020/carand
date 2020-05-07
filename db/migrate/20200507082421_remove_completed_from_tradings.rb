class RemoveCompletedFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :completed, :boolean
  end
end
