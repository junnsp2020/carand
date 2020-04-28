require "rails_helper"

RSpec.describe "Tradings", type: :system do
    describe "取引のテスト(購入者)" do
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
		context "商品を購入した時" do
			it "購入者画面・・・「出品者へ入金報告をする」と表示される" do
				click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				expect(page).to have_content "出品者へ入金報告をする"
        	end
        	it "購入者画面・・・やるべきことの数字「買った！ 1」が表示される" do
        		click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				expect(page).to have_content "買った！ 1"
        	end
        end
    	context "取引メッセージを送れるかどうかのテスト" do
			it "購入者画面・・・「テストメッセージ 1」を送付した際、取引画面に表示される" do
				click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				fill_in "trading_message[message]", with: "テストメッセージ 1"
  				click_button "取引メッセージを送る"
  				expect(page).to have_content "テストメッセージ 1"
        	end
        	it "購入者画面・・・出品者からメッセージが届いた場合、「出品者よりメッセージがあります」とヘッダーに表示される" do
        		click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
        		visit user_path(@user)
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "入金待ち"
				fill_in "trading_message[message]", with: "テストメッセージ 2"
  				click_button "取引メッセージを送る"
  				visit user_path(@user2)
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "出品者よりメッセージがあります"
        	end
        end
		context "購入者が入金報告を行ったとき" do
			it "購入者画面・・・「出品者の発送待ちです」と表示される" do
				click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				expect(page).to have_content "出品者の発送待ちです"
        	end
        	it "購入者画面・・・やるべきことの数字「買った！ 1」が消える" do
        		click_button "購入ページへ進む"
				@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				expect(page).not_to have_content "買った！ 1"
        	end
        end
        context "出品者が出荷報告を行ったとき" do
        	it "購入者画面・・・「商品が発送されました　到着後、受取評価をしてください」と表示される" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			expect(page).to have_content "商品が発送されました　到着後、受取評価をしてください"
	  		end
	  		it "購入者画面・・・やるべきことの数字「買った！ 1」が表示される" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "買った！ 1"
	  		end
	  	end
	  	context "購入者が取引相手を「良い」と評価したとき" do
	  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "購入者画面・・・やるべきことの数字「買った！ 1」が消える" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "買った！ 1"
	  		end
	  	end
	  	context "購入者が取引相手を「ふつう」と評価したとき" do
	  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_good_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "購入者画面・・・やるべきことの数字「買った！ 1」が消える" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_good_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "買った！ 1"
	  		end
	  	end
	  	context "購入者が取引相手を「わるい」と評価したとき" do
	  		it "購入者画面・・・「ご利用誠にありがとうございました！」と表示される" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "購入者画面・・・やるべきことの数字「買った！ 1」が消える" do
	  			click_button "購入ページへ進む"
		  		@trading = Trading.new(user_id: 1, product_id: @product.id, buyer_id: @user.id, seller_id: @user2.id)
				click_button "購入を確定する"
				@trading.save
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "買った！ 1"
	  		end
	  	end
	end

	describe "取引のテスト(出品者)" do
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
	  	end
	  	context "商品が購入されたとき" do
		  	it "出品者画面・・・「商品が購入されました　入金を待っています」と表示される" do
		  		click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "商品が購入されました　入金を待っています"
	    	end
	    end
	    context "取引メッセージを送れるかどうかのテスト" do
	    	it "出品者画面・・・「テストメッセージ 2」を送付した際、取引画面に表示される" do
	    		click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "入金待ち"
	  			fill_in "trading_message[message]", with: "テストメッセージ 2"
  				click_button "取引メッセージを送る"
  				expect(page).to have_content "テストメッセージ 2"
	  		end
	  		it "出品者画面・・・購入者からメッセージが届いた場合、「購入者よりメッセージがあります」とヘッダーに表示される" do
	  			fill_in "trading_message[message]", with: "テストメッセージ 1"
  				click_button "取引メッセージを送る"
  				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "購入者よりメッセージがあります"
	  		end
	  	end
	  	context "商品の代金が支払われたとき" do
	  		it "出品者画面・・・「購入者より代金が支払われました　商品を出荷してください」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			expect(page).to have_content "購入者より代金が支払われました　商品を出荷してください"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "売れた！ 1"
	  		end
	  	end
	  	context "出品者が出荷報告をした時" do
			it "出品者画面・・・「購入者の受取評価をお待ちください」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
		  		expect(page).to have_content "出荷を通知しました　購入者の受取評価をお待ちください"
			end
			it "出品者画面・・・やるべきことの数字「売れた！ 1」が消える" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
		  		expect(page).not_to have_content "売れた！ 1"
			end
		end
		context "購入者が取引相手を「良い」と評価したとき" do
			it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が表示される" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_excellent_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "売れた！ 1"
	  		end
		end
		context "購入者が取引相手を「ふつう」と評価したとき" do
			it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_good_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が表示される" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_good_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "売れた！ 1"
	  		end
		end
		context "購入者が取引相手を「わるい」と評価したとき" do
			it "出品者画面・・・「購入者が受け取りました　購入者の評価をしてください」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			expect(page).to have_content "購入者が受け取りました　購入者の評価をしてください"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が表示される" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			expect(page).to have_content "売れた！ 1"
	  		end
		end
		context "出品者が取引相手を「良い」と評価し、取引が完了した時" do
			it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_excellent_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が消える" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_excellent_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "売れた！ 1"
	  		end
		end
		context "出品者が取引相手を「ふつう」と評価し、取引が完了した時" do
			it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_good_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が消える" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_good_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "売れた！ 1"
	  		end
		end
		context "出品者が取引相手を「わるい」と評価し、取引が完了した時" do
			it "出品者画面・・・「ご利用誠にありがとうございました！」と表示される" do
				click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_poor_review_true"
	  			click_button "評価を確定する"
	  			expect(page).to have_content "ご利用誠にありがとうございました！"
	  		end
	  		it "出品者画面・・・やるべきことの数字「売れた！ 1」が消える" do
	  			click_link "出品者へ入金報告をする"
				click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "出荷してください"
	  			click_link "出荷報告をする"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user.email
	  			fill_in 'user[password]', with: @user.password
	  			click_button 'ログイン'
	  			click_link "買った！"
	  			click_link "商品到着後、受取評価してください"
	  			choose "trading_seller_poor_review_true"
	  			click_button "評価を確定する"
	  			click_link "マイページ"
				click_link "ログアウト"
				click_link "ログイン"
				fill_in 'user[email]', with: @user2.email
	  			fill_in 'user[password]', with: @user2.password
	  			click_button 'ログイン'
	  			click_link "売れた！"
	  			click_link "購入者の評価をお願いします"
	  			choose "trading_poor_review_true"
	  			click_button "評価を確定する"
	  			expect(page).not_to have_content "売れた！ 1"
	  		end
		end
	end
end