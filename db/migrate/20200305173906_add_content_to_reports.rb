class AddContentToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :content, :text
  end
end
