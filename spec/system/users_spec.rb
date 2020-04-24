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
end