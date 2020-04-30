require "rails_helper"

RSpec.describe "Users", type: :system do
    describe "新規登録のテスト" do
        context "新規登録画面に成功する" do
            before do
                @user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
            end
            it "全て入力してあるので保存される" do
                expect(@user).to be_valid
            end
        end
        context "新規登録に失敗する" do
            before do
                visit new_user_registration_path
            end
            it "入力に不備があるため保存されない" do
                fill_in "user[last_name]", with: ""
                fill_in "user[first_name]", with: ""
                fill_in "user[last_name_kana]", with: ""
                fill_in "user[first_name_kana]", with: ""
                fill_in "user[postcode]", with: ""
                fill_in "user[prefecture_code]", with: ""
                fill_in "user[address_city]", with: ""
                fill_in "user[address_street]", with: ""
                fill_in "user[email]", with: ""
                fill_in "user[nickname]", with: ""
                fill_in "user[password]", with: ""
                fill_in "user[phone_number]", with: ""
                click_button "登録"
                expect(page).to have_content "エラー"
            end
        end
    end
    describe "ログインのテスト" do
        before do
            @user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
            visit new_user_session_path
        end
        context "ログインに成功する" do
            it "入力に不備がないためログインできる" do
                fill_in "user[email]", with: "c@c"
                fill_in "user[password]", with: "111111"
                click_button "ログイン"
                expect(page).to have_content "マイページ"
            end
        end
        context "ログインに失敗する" do
            it "入力に不備があるためログインできない" do
                fill_in "user[email]", with: ""
                fill_in "user[password]", with: ""
                click_button "ログイン"
                expect(current_path).to eq(new_user_session_path)
            end
        end
    end
    describe 'サイドバーのテスト' do
        before do
            @user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
            @user2 = User.create!(last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g", nickname: "カランド2号", password: 222222, phone_number: "08022222222")
            visit new_user_session_path
            fill_in "user[email]", with: "c@c"
            fill_in "user[password]", with: "111111"
            click_button 'ログイン'
        end
        context '表示の確認' do
            it "マイページメニュー" do
                expect(page).to have_content("マイページメニュー")
            end
            it '「ほしいものリスト」が表示される' do
                expect(page).to have_content("ほしいものリスト")
            end
            it "「商品を出品する」が表示される" do
                expect(page).to have_content("商品を出品する")
            end
            it "「出品中の商品」が表示される" do
                expect(page).to have_content("出品中の商品")
            end
            it "「売れた商品」が表示される" do
                expect(page).to have_content("売れた商品")
            end
            it "「購入した商品」が表示される" do
                expect(page).to have_content("購入した商品")
            end
            it "「交換リクエスト 【 送った 】」が表示される" do
                expect(page).to have_content("交換リクエスト 【 送った 】")
            end
            it "「交換リクエスト 【 もらった 】」が表示される" do
                expect(page).to have_content("交換リクエスト 【 もらった 】")
            end
            it "ニックネームが表示される" do
                expect(page).to have_content(@user.nickname)
            end
            it "「個人情報」が表示される" do
                expect(page).to have_content("個人情報")
            end
            it "「ログアウト」が表示される" do
                expect(page).to have_content("ログアウト")
            end
            it "「個人情報詳細」リンクが表示される" do
                expect(page).to have_link '', href: userinfo_user_path(@user)
            end
            it "「残高」が表示される" do
                expect(page).to have_content("残高")
            end
            it "「個人情報の編集」リンクが表示される" do
                visit userinfo_user_path(@user)
                expect(page).to have_content("登録情報を編集する")
                click_link '登録情報を編集する'
                expect(page).to have_link '', href: edit_user_path(@user)
            end
        end
        context 'フォームの確認' do
            it '編集に成功する' do
                visit userinfo_user_path(@user)
                expect(page).to have_content("登録情報を編集する")
                click_link '登録情報を編集する'
                expect(page).to have_link '', href: edit_user_path(@user)
                visit edit_user_path(@user)
                click_button "編集を確定する"
                expect(current_path).to eq("/users/" + @user.id.to_s)
            end
        end
        context "他人のマイページへ移動" do
            it "マイページメニューが表示されない" do
                visit user_path(@user2)
                expect(page).not_to have_content("マイページメニュー")
            end
            it "残高が表示されない" do
                visit user_path(@user2)
                expect(page).not_to have_content("残高")
            end
        end
    end
end