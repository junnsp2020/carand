require "rails_helper"

RSpec.describe "BarterRequests", type: :system do
    describe "交換リクエストのテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
			visit new_user_session_path
	  		fill_in 'user[email]', with: @user.email
	  		fill_in 'user[password]', with: @user.password
	  		click_button 'ログイン'
	  		Category.create!(name: "おもちゃ・ホビー")
	  		visit products_path
	  	end
			context "交換可能な商品ページへ移動した時" do
				it "「この商品は交換可能です」と表示される" do
					@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", propriety: "交換可能", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  				visit product_path(@product)

					expect(page).to have_button "この商品は交換可能です"
            	end
        	end
        	context "交換不可の商品ページへ移動した時" do
				it "「この商品は交換不可です」と表示される" do
					@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", propriety: "交換不可", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  				visit product_path(@product)

					expect(page).to have_button "この商品は交換不可です"
            	end
        	end
        	context "交換リクエストを送った時" do
				it "「投稿されたリクエスト一覧」が表示される" do
					@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", propriety: "交換可能", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  				visit product_path(@product)

					expect(page).to have_button "この商品は交換可能です"
					click_button "この商品は交換可能です"
					@barterRequest = BarterRequest.create!(user_id: 1 , product_id: 1, name: "交換用商品 A", comment: "交換希望です！宜しくお願い致します。", introduction: "大切に使用してきた商品Aです。傷はほとんどありません。何卒宜しくお願い致します!", image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
					expect(page).to have_button "リクエストを送信"
					click_button "リクエストを送信"
					expect(page).to have_content "投稿されたリクエスト一覧"
            	end
        	end
        	context "交換リクエストをもらった時" do
				it "「交換リクエストがきています　内容を覗いてみましょう」と表示される" do
					@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", propriety: "交換可能", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  				visit product_path(@product)

					expect(page).to have_button "この商品は交換可能です"
					click_button "この商品は交換可能です"
					@barterRequest = BarterRequest.create!(user_id: 1 , product_id: 1, name: "交換用商品 A", comment: "交換希望です！宜しくお願い致します。", introduction: "大切に使用してきた商品Aです。傷はほとんどありません。何卒宜しくお願い致します!", image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
					expect(page).to have_button "リクエストを送信"
					click_button "リクエストを送信"
					expect(page).to have_content "投稿されたリクエスト一覧"
					visit user_path(@user)
					expect(page).to have_content "マイページ"
					click_link "マイページ"
					expect(page).to have_content "ログアウト"
					click_link "ログアウト"
					expect(page).to have_content "ログイン"
					click_link "ログイン"
					expect(page).to have_content "こちらからログイン"
					fill_in 'user[email]', with: @user2.email
		  			fill_in 'user[password]', with: @user2.password
		  			click_button 'ログイン'
		  			expect(page).to have_content "交換リクエストがきています　内容を覗いてみましょう"
            	end
        	end
    end
	    describe "交換リクエストをもらった時のテスト" do
	    	before do
		    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
				@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
				visit new_user_session_path
		  		fill_in 'user[email]', with: @user.email
		  		fill_in 'user[password]', with: @user.password
		  		click_button 'ログイン'
		  		Category.create!(name: "おもちゃ・ホビー")
		  		visit products_path
		  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", propriety: "交換可能", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
  				visit product_path(@product)
				expect(page).to have_button "この商品は交換可能です"
				click_button "この商品は交換可能です"
				@barterRequest = BarterRequest.create!(user_id: 1 , buyer_id: 1, seller_id: 2, product_id: 1, name: "交換用商品 A", comment: "交換希望です！宜しくお願い致します。", introduction: "大切に使用してきた商品Aです。傷はほとんどありません。何卒宜しくお願い致します!", image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
				expect(page).to have_button "リクエストを送信"
				click_button "リクエストを送信"
				expect(page).to have_content "投稿されたリクエスト一覧"
				visit user_path(@user)
				expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "交換リクエストがきています　内容を覗いてみましょう"
	  		end
	  		context "交換リクエストを許可した時" do
				it "リクエストを許可した側・・・「リクエストを許可しました」と表示される" do
				click_link "交換リクエストがきています　内容を覗いてみましょう"
				expect(page).to have_content "相手の提案商品"
				select "許可する", from: "barter_request_propriety", match: :first
				expect(page).to have_button "確定"
				click_button "確定", match: :first
				expect(page).to have_content "リクエストを許可しました"
				end
				it "リクエストを送った側・・・「リクエストが許可されました」と表示される" do
				click_link "交換リクエストがきています　内容を覗いてみましょう"
				expect(page).to have_content "相手の提案商品"
				select "許可する", from: "barter_request_propriety", match: :first
				expect(page).to have_button "確定"
				click_button "確定", match: :first
				expect(page).to have_content "リクエストを許可しました"   ###ここまでは正しい
				visit user_path(@user2)
				expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button "ログイン"
	  			expect(page).to have_content "リクエストが許可されました"
				end
			end
	    end
end
