require "rails_helper"

RSpec.describe "Header", type: :system do
  describe "ヘッダーのテスト" do
    describe "ログインしていない場合" do
      before do
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
    end
  end
end