# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Administer.create!(
   email: "z@z",
   password: "777777",
)

User.create([
	{last_name: "カランド", first_name: "1号", last_name_kana: "カランド", first_name_kana: "イチゴウ", postcode: 1111111, prefecture_code: "カランド県", address_city: "カランド市", address_street: "カランド町", email: "c@c" , introduction: "よろしくお願いします！", nickname: "カランド１号", password: 111111},
	{last_name: "カランド", first_name: "2号", last_name_kana: "カランド", first_name_kana: "ニゴウ", postcode: 2222222, prefecture_code: "A県", address_city: "A市", address_street: "A町", email: "g@g" , introduction: "よろしくお願いします！", nickname: "カランド2号", password: 222222},
	{last_name: "カランド", first_name: "3号", last_name_kana: "カランド", first_name_kana: "サンゴウ", postcode: 3333333, prefecture_code: "B県", address_city: "B市", address_street: "B町", email: "v@v" , introduction: "よろしくお願いします！", nickname: "カランド3号", password: 333333}
])

Category.create([
  	{name: "おもちゃ・ホビー"},
  	{name: "ゲームソフト"},
  	{name: "ゲーム機本体"},
  	{name: "トレーディングカード"},
  	{name: "衣類"},
  	{name: "アクセサリー・小物"},
  	{name: "バッグ"},
  	{name: "時計"},
  	{name: "家電"},
  	{name: "家具"}
])

Product.create!([
	{user_id: 1 , category_id: 1, name: "商品 1", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 5000}
	{user_id: 2 , category_id: 2, name: "商品 2", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 6500, propriety: 1}
	{user_id: 3 , category_id: 3, name: "商品 3", introduction: "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。", price: 8000, propriety: 1, sale_status: 0}