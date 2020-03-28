# カランド

<URL: http//18.180.81.161>
## 概要
フリマサイト「カランド」では、商品の売買だけでなく、交換も可能となっています。

## バージョン
ruby 2.5.7
Rails 5.2.4.1

## 機能一覧:

### A. 出品 → 売れた場合の流れ    
**(1) 「マイページ」 → 「商品を出品する or カメラマーク をクリック」**
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77818420-76d2cd80-7115-11ea-8c78-98515d3309fc.png">
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77818448-a97cc600-7115-11ea-8710-009af43e0edc.png">
      
**(2) 出品商品の詳細を記述 → 「出品する」をクリック**  
交換の可否の項目で「交換可能」にしておけば、他のユーザーから  
交換リクエストがくる可能性があります。
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77818455-c618fe00-7115-11ea-83bc-1c72330056df.png">
      
**(3) 出品処理は以上です**  
自分が出品した商品には「～さんが出品した商品です」と表示され
購入はできません。
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77818465-e779ea00-7115-11ea-93db-c12f926965aa.png">
<br>　　
**(4) 商品が売れた場合**
「商品が購入されました」とメッセージが表示されます。購入者の入金完了まで待機してください。
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819424-20b65800-711e-11ea-9afb-bc47613bbe1e.png">
### B. 商品を検索する    
**(1)「ヘッダーの検索窓 or カテゴリーからもお探しできます をクリック」**  
(検索窓にキーワードを入れないで虫眼鏡マークを押すと、全ての商品を検索できます)
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819318-60307480-711d-11ea-8910-7d6e989adb1f.png">

**(2)自分が見たい商品をクリックしてください**  
商品一覧には、「販売中」「交換可」「売切」のタグが設定してあります。
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819362-a38ae300-711d-11ea-88ee-2561bb3a848c.png">

### C. 購入 or 交換 → 取引の流れ
####B-1.「購入する場合]**
**(1)「購入ページへ進む」をクリックし取引確定画面へ進んでください。**
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819386-ca491980-711d-11ea-85b2-4a8622cd8dc8.png">

**(2)「購入を確定する」をクリック**
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819393-df25ad00-711d-11ea-8baa-5dbbc8bd7594.png">  
**(3)入金報告をしてください**
入金報告完了後、商品は発送されます

<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819410-03818980-711e-11ea-91d9-9bfcc30915e7.png">
 ↓
「出品者の出荷報告」
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819424-20b65800-711e-11ea-9afb-bc47613bbe1e.png">
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819457-552a1400-711e-11ea-8966-16dd08b91b31.png">



 ↓
「購入者が受取評価をし、その後出品者の方も評価できる」
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819477-6ecb5b80-711e-11ea-95f6-5784c71c6d26.png">
<img width="800px" src="https://user-images.githubusercontent.com/58461408/77819479-77239680-711e-11ea-93d6-54532f6c739b.png">


という流れです。後述しますが、自分がやるべきことが
ある場合は、ヘッダーに表示されます。
ヘッダーをクリックし、該当ページへ進みましょう。(ヘッダー参照)



 B.「交換可」の商品を交換したい場合
「この商品は交換可能です」をクリックし、
次に出てくる画面で、自分の提案商品を投稿します
 ↓
この「WANTED!」という画面が表示されると、投稿完了です。
交換が承認されることを期待して待ちましょう!
 ↓
承認された場合は、ヘッダーに「リクエストが許可されました」と表示されますので
クリックしてください。クリックするとオレンジ色のボタンが出ていますので、
押すと、交換取引の確定ページへと進めます。
 ↓
※交換の場合は、支払方法を必ず「交換」としてください
 ↓
※メッセージ機能を使用し、お互いに送り状番号を送り合いましょう
 ↓
商品到着後、お相手の評価をしてください

という流れです。自分がやるべきことがある場合は、
ヘッダーに表示されます(ヘッダー)

###3. ヘッダー(通知機能)

取引において、自分がやるべきことがある場合と
お相手からメッセージが届いた場合は、
ヘッダーに表示されます。
もし表示された場合は、ヘッダーをクリックして
該当のアクションへと進んでください。

###4. マイページメニュー

マイページメニューでは、
・「購入した商品」
・「出品中の商品」、「売れた商品」
・「自分が送った交換リクエスト」、「他のユーザーからもらった交換リクエスト」
・「ほしいものリストに登録した商品」
を閲覧できます。

また「個人情報詳細」をクリックすれば
登録情報の確認、及び編集ができます。

「カランド残高」には売れた商品の利益総額が表示されています。
振込申請をクリックし、受け取りたい金額を
入力してください。





* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
