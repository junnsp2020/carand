require "rails_helper"

RSpec.describe "Administerモデルのテスト", type: :system do
    describe "新規登録のテスト" do
        context "新規登録画面に成功する" do
            before do
                @administer = Administer.create!(email: "c@c" , password: 111111)
            end
            it "全て入力してあるので保存される" do
                expect(@administer).to be_valid
            end
        end
        context "新規登録に失敗する" do
            before do
                visit new_administer_registration_path
            end
            it "入力に不備があるため保存されない" do
                fill_in "administer[password]", with: ""
                fill_in "administer[email]", with: ""
                click_button "Sign up"

                expect(page).to have_content "error"
            end
        end
    end
    describe "ログインのテスト" do
        before do
            @administer = Administer.create!(email: "Z@Z" , password: 777777)
            visit new_administer_session_path
        end
        context "ログインに成功する" do
            it "入力に不備がないためログインできる" do
                fill_in "administer[email]", with: "z@z"
                fill_in "administer[password]", with: 777777
                click_button "ログイン"

                expect(page).to have_content "管理者画面"
            end
        end
        context "ログインに失敗する" do
            it "入力に不備があるためログインできない" do
                fill_in "administer[email]", with: ""
                fill_in "administer[password]", with: ""
                click_button "ログイン"

                expect(current_path).to eq(new_administer_session_path)
            end
        end
    end
    describe "表示のテスト" do
        before do
            @administer = Administer.create!(email: "Z@Z" , password: 777777)
            visit new_administer_session_path
            fill_in "administer[email]", with: "z@z"
            fill_in "administer[password]", with: 777777
            click_button "ログイン"
        end
        context "ログインした時" do
            it "「通報一覧へ」が表示される" do
                expect(page).to have_content("通報一覧へ")
            end
            it "「カテゴリー追加」が表示される" do
                expect(page).to have_content("カテゴリー追加")
            end
        end
    end
end