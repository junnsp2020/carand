FactoryBot.define do
	factory :user, class: User do
		last_name {"カランド"}
		first_name {"1号"}
		last_name_kana {"カランド"}
		first_name_kana {"イチゴウ"}
		postcode {"1111111"}
		prefecture_code {"カランド県"}
		address_city {"カランド市"}
		address_street {"カランド町"}
		email {"c@c"}
		nickname {"カランド１号"}
		password {"111111"}
		phone_number {"08011111111"}
	end
end