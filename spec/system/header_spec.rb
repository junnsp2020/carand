require "rails_helper"

RSpec.describe "Header", type: :system do
    describe "ヘッダーのテスト" do 
      before do
        @user = User.create!(last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , nickname: "カランド１号", password: 111111, phone_number: "08011111111")
        visit root_path
      end
      context "ヘッダーの表示を確認" do
        subject { page }
        it "Aboutリンクが表示される" do
          expect(page).to have_content "カランドって何？"
        end
        it "「ログイン」リンクが表示される" do
          is_expected.to have_content "ログイン"
        end
        it "「新規会員登録」リンクが表示される" do
          expect(page).to have_content "新規会員登録"
        end
      end
      context "ログイン後" do
        subject { page }
          it "「買った！」リンクが表示される" do
              visit new_user_session_path
              fill_in 'user[email]', with: @user.email
              fill_in 'user[password]', with: @user.password
              click_button 'ログイン'
              expect(page).to have_content "買った！"
          end
          it "「売れた！」リンクが表示される" do
              visit new_user_session_path
              fill_in 'user[email]', with: @user.email
              fill_in 'user[password]', with: @user.password
              click_button 'ログイン'
              expect(page).to have_content "売れた！"
          end
          it "「交換！」リンクが表示される" do
              visit new_user_session_path
              fill_in 'user[email]', with: @user.email
              fill_in 'user[password]', with: @user.password
              click_button 'ログイン'
              expect(page).to have_content "交換！"
          end
          it "「マイページ」リンクが表示される" do
              visit new_user_session_path
              fill_in 'user[email]', with: @user.email
              fill_in 'user[password]', with: @user.password
              click_button 'ログイン'
              expect(page).to have_content "マイページ"
          end
      end
    end
end