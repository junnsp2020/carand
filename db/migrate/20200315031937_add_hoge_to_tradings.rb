class AddHogeToTradings < ActiveRecord::Migration[5.2]
  def change
    add_column :tradings, :hoge, :integer
  end
end
