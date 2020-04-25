require "rails_helper"

RSpec.describe "Tradings", type: :system do
    describe "取引のテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
			visit new_user_session_path
	  		fill_in 'user[email]', with: @user.email
	  		fill_in 'user[password]', with: @user.password
	  		click_button 'ログイン'
	  		Category.create!(name: "おもちゃ・ホビー")
	  		visit products_path
	  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  		visit product_path(@product)
	  	end
			context "他人の商品ページへ移動した時" do
				it "購入ページへ進むことができる" do
					click_button "購入ページへ進む"

					expect(current_path).to eq(new_trading_path)
            	end
        	end
    end
    describe "取引のテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
			visit new_user_session_path
	  		fill_in 'user[email]', with: @user.email
	  		fill_in 'user[password]', with: @user.password
	  		click_button 'ログイン'
	  		Category.create!(name: "おもちゃ・ホビー")
	  		visit products_path
	  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  		visit product_path(@product)
	  		click_button "購入ページへ進む"
	  	end
			context "他人の商品を購入した時" do
				it "入金報告を行うボタンが現れる" do
					@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
					click_button "購入を確定する"
					@trading.save

					expect(page).to have_content "出品者へ入金報告をする"
            	end
        	end
    end
    describe "取引のテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
	  	end
			context "入金報告を行ったとき" do
				it "出品者の発送待ちとなる" do
					visit new_user_session_path
			  		fill_in 'user[email]', with: @user.email
			  		fill_in 'user[password]', with: @user.password
			  		click_button 'ログイン'
			  		Category.create!(name: "おもちゃ・ホビー")
			  		visit products_path
			  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
			  		visit product_path(@product)
			  		click_button "購入ページへ進む"
					@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
					click_button "購入を確定する"
					@trading.save
					expect(page).to have_content "出品者へ入金報告をする"
					click_link "出品者へ入金報告をする"
					expect(page).to have_content "出品者の発送待ちです"
            	end
        	end
    end
    describe "取引のテスト" do
	    before do
	    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
			@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
			visit new_user_session_path
	  		fill_in 'user[email]', with: @user.email
	  		fill_in 'user[password]', with: @user.password
	  		click_button 'ログイン'
	  		Category.create!(name: "おもちゃ・ホビー")
	  		visit products_path
	  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
	  		visit product_path(@product)
	  		click_button "購入ページへ進む"
	  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
			click_button "購入を確定する"
			@trading.save
			expect(page).to have_content "出品者へ入金報告をする"
			click_link "出品者へ入金報告をする"
		end
		context "購入者がログアウトした時" do
			it "トップページへ移動する" do
				expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				expect(current_path).to eq(root_path)
			end
	  	end
    end
	describe "取引のテスト" do
		    before do
		    	@user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
				@user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
				visit new_user_session_path
		  		fill_in 'user[email]', with: @user.email
		  		fill_in 'user[password]', with: @user.password
		  		click_button 'ログイン'
		  		Category.create!(name: "おもちゃ・ホビー")
		  		visit products_path
		  		@product = Product.create!(user_id: 2 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
		  		visit product_path(@product)
		  		click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				expect(page).to have_content "出品者へ入金報告をする"
				click_link "出品者へ入金報告をする"
				expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
			end
			context "出品者が出荷報告をした時" do
				it "購入者の受取評価を待つように指示される" do
					expect(page).to have_content "ログイン"
					click_link "ログイン"
					expect(page).to have_content "こちらからログイン"
					fill_in 'user[email]', with: @user2.email
		  			fill_in 'user[password]', with: @user2.password
		  			click_button 'ログイン'
		  			expect(page).to have_content "売れた！"
		  			click_link "売れた！"
		  			expect(page).to have_content "出荷してください"
		  			click_link "出荷してください"
		  			expect(page).to have_content "出荷報告をする"
		  			click_link "出荷報告をする"
		  			expect(page).to have_content "出荷を通知しました　購入者の受取評価をお待ちください"
				end
		  	end
	end
end