require "rails_helper"

RSpec.describe "Products", type: :system do
    describe "商品出品のテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			visit new_user_session_path
	  		fill_in 'user[email]', with: @user.email
	  		fill_in 'user[password]', with: @user.password
	  		click_button 'ログイン'
	  		visit new_product_path
	  		Category.create!(name: "おもちゃ・ホビー")
	  	end
		context "商品の出品に成功する" do
			it "全て入力してあるので保存される" do
				@product = Product.create!(user_id: 1 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))

            	expect(@product).to be_valid
        	end
    	end
    	context "商品の出品に失敗する" do
    		it "入力項目に不備があり失敗する" do
                fill_in "product[name]", with: ""
                fill_in "product[price]", with: ""
                attach_file "product[image]", "spec/fixtures/no_image.jpg"
				click_button "出品する"

                expect(page).to have_content "データの保存に失敗しました"
        	end
    		it "画像が選択されず失敗する" do
                fill_in "product[name]", with: ""
                fill_in "product[price]", with: ""
				click_button "出品する"

                expect(page).to have_content "画像が選択されていません"
        	end
        end
    end
end