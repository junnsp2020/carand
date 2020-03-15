class RemoveHogeFromTradings < ActiveRecord::Migration[5.2]
  def change
    remove_column :tradings, :hoge, :integer
  end
end
