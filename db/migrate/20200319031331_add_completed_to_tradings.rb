class AddCompletedToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :completed, :boolean
  end
end
