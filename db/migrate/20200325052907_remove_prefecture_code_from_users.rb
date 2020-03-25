class RemovePrefectureCodeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :prefecture_code, :integer
  end
end
