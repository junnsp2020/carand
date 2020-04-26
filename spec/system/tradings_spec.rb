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
				it "購入者画面・・・「出品者へ入金報告をする」と表示される" do
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
			context "購入者が入金報告を行ったとき" do
				it "購入者画面・・・「出品者の発送待ちです」と表示される" do
					expect(page).to have_content "出品者の発送待ちです"
            	end
				it "出品者画面・・・「購入者より代金が支払われました　商品を出荷してください」と表示される" do
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
		  			expect(page).to have_content "売れた！"
		  			click_link "売れた！"
		  			expect(page).to have_content "出荷してください"
		  			click_link "出荷してください"
		  			expect(page).to have_content "購入者より代金が支払われました　商品を出荷してください"
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
			end
			context "出品者が出荷報告をした時" do
				it "出品者画面・・・「購入者の受取評価をお待ちください」と表示される" do
		  			expect(page).to have_content "出荷を通知しました　購入者の受取評価をお待ちください"
				end
		  		it "購入者画面・・・「商品が発送されました　到着後、受取評価をしてください」と表示される" do
		  			expect(page).to have_content "マイページ"
					click_link "マイページ"
					expect(page).to have_content "ログアウト"
					click_link "ログアウト"
					expect(page).to have_content "ログイン"
					click_link "ログイン"
					expect(page).to have_content "こちらからログイン"
					fill_in 'user[email]', with: @user.email
		  			fill_in 'user[password]', with: @user.password
		  			click_button 'ログイン'
		  			expect(page).to have_content "買った！"
		  			click_link "買った！"
		  			expect(page).to have_content "商品到着後、受取評価してください"
		  			click_link "商品到着後、受取評価してください"
		  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
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
	  			expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "買った！"
	  			click_link "買った！"
	  			expect(page).to have_content "商品到着後、受取評価してください"
	  			click_link "商品到着後、受取評価してください"
	  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
	  			expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "買った！"
	  			click_link "買った！"
	  			expect(page).to have_content "商品到着後、受取評価してください"
	  			click_link "商品到着後、受取評価してください"
	  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
			end
			context "購入者が取引相手を「良い」と評価したとき" do
				# it "出品者画面・・・「購入者の受取評価をお待ちください」と表示される" do
		  # 			expect(page).to have_content "出荷を通知しました　購入者の受取評価をお待ちください"
				# end
		  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_seller_excellent_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  		it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
		  			choose "trading_seller_excellent_review_true"
		  			click_button "評価を確定する"
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
		  			expect(page).to have_content "売れた！"
		  			click_link "売れた！"
		  			expect(page).to have_content "購入者の評価をお願いします"
		  			click_link "購入者の評価をお願いします"
		  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
		  		end
		  	end
		  	context "購入者が取引相手を「ふつう」と評価したとき" do
				# it "出品者画面・・・「購入者の受取評価をお待ちください」と表示される" do
		  # 			expect(page).to have_content "出荷を通知しました　購入者の受取評価をお待ちください"
				# end
		  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_seller_good_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  		it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
		  			choose "trading_seller_good_review_true"
		  			click_button "評価を確定する"
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
		  			expect(page).to have_content "売れた！"
		  			click_link "売れた！"
		  			expect(page).to have_content "購入者の評価をお願いします"
		  			click_link "購入者の評価をお願いします"
		  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
		  		end
		  	end
		  	context "購入者が取引相手を「わるい」と評価したとき" do
		  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_seller_poor_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  		it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
		  			choose "trading_seller_poor_review_true"
		  			click_button "評価を確定する"
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
		  			expect(page).to have_content "売れた！"
		  			click_link "売れた！"
		  			expect(page).to have_content "購入者の評価をお願いします"
		  			click_link "購入者の評価をお願いします"
		  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
		  		end
		  	end
	end
	describe "購入者が取引相手を「良い」と評価した時のテスト" do
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
	  			expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "買った！"
	  			click_link "買った！"
	  			expect(page).to have_content "商品到着後、受取評価してください"
	  			click_link "商品到着後、受取評価してください"
	  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
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
	  			expect(page).to have_content "売れた！"
	  			click_link "売れた！"
	  			expect(page).to have_content "購入者の評価をお願いします"
	  			click_link "購入者の評価をお願いします"
	  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
			end
			context "出品者が取引相手を「良い」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_excellent_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
		  	context "出品者が取引相手を「ふつう」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_good_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
		  	context "出品者が取引相手を「わるい」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_poor_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
	end
	describe "購入者が取引相手を「ふつう」と評価した時のテスト" do
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
	  			expect(page).to have_content "マイページ"
				click_link "マイページ"
				expect(page).to have_content "ログアウト"
				click_link "ログアウト"
				expect(page).to have_content "ログイン"
				click_link "ログイン"
				expect(page).to have_content "こちらからログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "買った！"
	  			click_link "買った！"
	  			expect(page).to have_content "商品到着後、受取評価してください"
	  			click_link "商品到着後、受取評価してください"
	  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
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
	  			expect(page).to have_content "売れた！"
	  			click_link "売れた！"
	  			expect(page).to have_content "購入者の評価をお願いします"
	  			click_link "購入者の評価をお願いします"
	  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
			end
			context "出品者が取引相手を「良い」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_excellent_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
		  	context "出品者が取引相手を「ふつう」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_good_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
		  	context "出品者が取引相手を「わるい」と評価したとき" do
		  		it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
		  			choose "trading_poor_review_true"
		  			click_button "評価を確定する"
		  			expect(page).to have_content "ご利用誠にありがとうございました！"
		  		end
		  	end
	end
end