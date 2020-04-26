require "rails_helper"

RSpec.describe "Productモデルのテスト", type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let!(:product) { FactoryBot.create(:product, user_id: user.id, category_id: category.id) }
  before(:each) do
    product
  end

  describe "botを使ったバリデーションのテスト" do
    it "項目が全て入力されているため有効である" do
      expect(product).to be_valid
    end
  end

  describe "バリデーションのテスト" do
    context "メールアドレスが空の時" do
      it "バリデーションがエラーになる" do
        product.name = ""
        expect(product).to be_invalid
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Product.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
