require "rails_helper"

RSpec.describe "Productモデルのテスト", type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let!(:product) { FactoryBot.create(:product, user_id: user.id, category_id: category.id) }
  before(:each) do
    product
  end

  describe "バリデーションのテスト" do
    context "全ての項目が入力されている時" do
      it "有効である" do
        expect(product).to be_valid
      end
    end
    context "メールアドレスが空の時" do
      it "エラーとなる" do
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
