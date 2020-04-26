require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    user
  end

  describe "バリデーションのテスト" do
    context "入力内容に不備がない時" do
      it "有効である" do
        expect(user).to be_valid
      end
    end
    context "メールアドレスが空の時" do
      it "バリデーションがエラーになる" do
        user.email = ""
        expect(user).to be_invalid
      end
    end
    context "パスワードが空の時" do
      it "バリデーションがエラーになる" do
        user.password = ""
        expect(user).to be_invalid
      end
    end
    context "姓が空の時" do
      it "バリデーションがエラーになる" do
        user.last_name = ""
        expect(user).to be_invalid
      end
    end
    context "名が空の時" do
      it "バリデーションがエラーになる" do
        user.first_name = ""
        expect(user).to be_invalid
      end
    end
    context "姓(カナ)が空の時" do
      it "バリデーションがエラーになる" do
        user.last_name_kana = ""
        expect(user).to be_invalid
      end
    end
    context "名(カナ)が空の時" do
      it "バリデーションがエラーになる" do
        user.first_name_kana = ""
        expect(user).to be_invalid
      end
    end
    context "郵便番号が空の時" do
      it "バリデーションがエラーになる" do
        user.postcode = ""
        expect(user).to be_invalid
      end
    end
    context "都道府県名が空の時" do
      it "バリデーションがエラーになる" do
        user.prefecture_code = ""
        expect(user).to be_invalid
      end
    end
    context "市区町村名が空の時" do
      it "バリデーションがエラーになる" do
        user.address_city = ""
        expect(user).to be_invalid
      end
    end
    context "番地名が空の時" do
      it "バリデーションがエラーになる" do
        user.address_street = ""
        expect(user).to be_invalid
      end
    end
    context "電話番号が空の時" do
      it "バリデーションがエラーになる" do
        user.phone_number = ""
        expect(user).to be_invalid
      end
    end
    context "ニックネームが空の時" do
      it "バリデーションがエラーになる" do
        user.nickname = ""
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
