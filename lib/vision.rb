require 'base64' ##パッケージの読み込み
require 'json'
require 'net/https'
module Vision
  class << self
    def get_image_data(image_file)
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_VISION_API_KEY']}"
      # 画像をbase64にエンコード
      if Rails.env.production?  ##本番環境にだけ表示させる
        base64_image = Base64.encode64(open(image_file.url).read) ##web上からファイルをダウンロードする
      else
        base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.id}").read)
      end
      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'SAFE_SEARCH_DETECTION'
            }
          ]
        }]
      }.to_json
      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url) #URLの文字列をURIオブジェクトへと生成
      https = Net::HTTP.new(uri.host, uri.port) ##リクエストを開く前のオブジェクトを作る
      https.use_ssl = true ##SSL接続できるようにする
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      JSON.parse(response.body)['responses'][0]['safeSearchAnnotation']
    end
  end
end