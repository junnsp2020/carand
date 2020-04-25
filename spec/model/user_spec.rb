require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    user
  end

  describe "botを使ったバリデーションのテスト" do
    it "項目が全て入力されているため有効である" do
      expect(user).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    context "メールアドレスが空の時" do
      it "バリデーションがエラーになる" do
        user.email = ""
        expect(user).to be_invalid
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Productモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:products).macro).to eq :has_many
      end
    end
  end
end
