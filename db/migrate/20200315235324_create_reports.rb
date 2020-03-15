class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :subject
      t.text :content

      t.timestamps
    end
  end
end
