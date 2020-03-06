class CreateBlogFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_follows do |t|

      t.timestamps
    end
  end
end
