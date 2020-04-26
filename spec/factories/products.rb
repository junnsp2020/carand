FactoryBot.define do
	factory :product, class: Product do
		name { "商品 1" }
		introduction { "大切に使用してきた商品です。梱包は厳重に致しますのでご安心ください。" }
		price { "5000" }
		image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.jpg'), 'image/jpg') }
	end
end