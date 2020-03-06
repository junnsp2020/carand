class AddStatusToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :status, :boolean
  end
end
