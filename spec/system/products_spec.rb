require "rails_helper"

RSpec.describe "Products", type: :system do
    describe "商品出品のテスト" do
        before do
            @user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
            @user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
            visit new_user_session_path
            fill_in 'user[email]', with: @user.email
            fill_in 'user[password]', with: @user.password
            click_button 'ログイン'
            visit new_product_path
            Category.create!(name: "おもちゃ・ホビー")
        end
        context "入力内容に不備がない時" do
            it "正常に出品できる" do
                @product = Product.create!(user_id: 1 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
                expect(@product).to be_valid
            end
        end
        context "入力項目に不備がある時" do
            it "出品に失敗する" do
                fill_in "product[name]", with: ""
                fill_in "product[price]", with: ""
                attach_file "product[image]", "spec/fixtures/no_image.jpg"
                click_button "出品する"
                expect(page).to have_content "データの保存に失敗しました"
            end
        end
        context "画像が選択されていない時" do
            it "「画像が選択されていません」と表示される" do
                fill_in "product[name]", with: ""
                fill_in "product[price]", with: ""
                click_button "出品する"
                expect(page).to have_content "画像が選択されていません"
            end
        end
        context "自分の商品へ移動した時" do
            it "購入ボタンが表示されない" do
                @product = Product.create!(user_id: 1 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
                visit product_path(@product)
                expect(page).not_to have_content("購入ページへ進む")
            end
        end
        context "他人の商品へ移動した時" do
            it "購入ページへ進むことができる" do
                @product = Product.create!(user_id: 2 , category_id: 1, name: "商品 2", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 6000, image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg'))
                visit product_path(@product)
                click_button "購入ページへ進む"
                expect(current_path).to eq("/tradings/new")
            end
        end
    end
end