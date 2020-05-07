class RemovePostageFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :postage, :integer
  end
end
