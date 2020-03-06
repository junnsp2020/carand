class AddImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_id, :string
    add_column :users, :introduction, :text
    add_column :users, :postcode, :integer
    add_column :users, :prefecture_code, :integer
    add_column :users, :address_city, :string
    add_column :users, :address_street, :string
    add_column :users, :phone_number, :string
    add_column :users, :is_deleted, :boolean
    add_column :users, :bank_name, :string
    add_column :users, :account_type, :string
    add_column :users, :branch_code, :string
    add_column :users, :account_number, :string
    add_column :users, :account_last_name_kana, :string
    add_column :users, :account_first_name_kana, :string
    add_column :users, :balance, :integer
  end
end
