# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
p '==================== customer create ===================='
Customer.create!(name: "Yamada Taro", email: "yamada.taro@gmail.com", password: "111111")
Customer.create!(name: "Sato Mamoru", email: "sato.mamoru@gmail.com", password: "111111")
Customer.create!(name: "Tanaka Saki", email: "tanaka.saki@gmail.com", password: "111111")
Customer.create!(name: "Hoshino Yui", email: "hoshino.yui@gmail.com", password: "111111")
Customer.create!(name: "Saito Kazuma", email: "saito.kazuma@gmail.com", password: "111111")

p '==================== admin create ===================='
Admin.create!(email: "admin@gmail.com", password: "1234qwer")

p '==================== product create ===================='
product1 = Product.new(
  name: "PBプリントクルーネック長袖Tシャツ",
  description: "【日本限定】プチバトーのロゴとメッセージプリントが印象的なＴシャツ
                ブランドを代表するクルーネック長袖Tシャツに、日本限定デザインが登場。「第二の肌」と呼ばれるやわらかな手触りの1x1リブ編み素材で美しいシルエットと着心地の良さを提供します。Bonjourとブランドロゴがアクセントとなり、さりげないおしゃれを叶える一枚。",
  price: 6600,
  stock: 30
)
product1.image.attach(io: File.open(Rails.root.join('app/assets/images/tops1.jpg')), filename: 'tops1.jpg')
product1.save!

product2 = Product.new(
  name: "foxco×PB長袖クルーネックＴシャツ",
  description: "イラストレーターの foxco さんとコラボレーションした日本限定のラウンジウェアコレクションが新登場！
                イラストレーターのfoxcoさんとコラボレーションした長袖Tシャツ。程よい厚みのある平編み素材を使用したユニセックスで着られるデザインです。快適な着心地はリラックスタイムにもぴったり。他のコラボレーションアイテムとのコーディネイトもおすすめです。",
  price: 11990,
  stock: 21
)
product2.image.attach(io: File.open(Rails.root.join('app/assets/images/tops2.jpg')), filename: 'tops2.jpg')
product2.save!

product3 = Product.new(
  name: "Shogo Sekine プリント半袖Ｔシャツ",
  description: "TイラストレーターのSHOGO SEKINE氏とのコラボレーションから生まれた、Parisムード溢れるキュートなコレクションが登場！",
  price: 5000,
  stock: 10
)
product3.image.attach(io: File.open(Rails.root.join('app/assets/images/tops3.jpg')), filename: 'tops3.jpg')
product3.save!

product4 = Product.new(
  name: "foxco×PBスウェットパンツ",
  description: "Tイラストレーターの foxco さんとコラボレーションした日本限定のラウンジウェアコレクションが新登場！",
  price: 19800,
  stock: 12
)
product4.image.attach(io: File.open(Rails.root.join('app/assets/images/bottoms1.jpg')), filename: 'bottoms1.jpg')
product4.save!

product5 = Product.new(
  name: "デニムパンツ",
  description: "着回し力抜群！プチバトーの人気デニムでおしゃれを楽しもう！",
  price: 22000,
  stock: 8
)
product5.image.attach(io: File.open(Rails.root.join('app/assets/images/bottoms2.jpg')), filename: 'bottoms2.jpg')
product5.save!

product6 = Product.new(
  name: "ヨットパーカ",
  description: "プチバトーの定番アイテム、ヨットパーカにAラインタイプが仲間入り",
  price: 34100,
  stock: 30
)
product6.image.attach(io: File.open(Rails.root.join('app/assets/images/outer1.jpg')), filename: 'outer1.jpg')
product6.save!

product7 = Product.new(
  name: "ミリタリージャケット",
  description: "Tミリタリーデザインでおしゃれに防寒！あらゆるシーンで着回せる万能コート",
  price: 38500,
  stock: 30
)
product7.image.attach(io: File.open(Rails.root.join('app/assets/images/outer2.jpg')), filename: 'outer2.jpg')
product7.save!

product8 = Product.new(
  name: "ボーダー半袖ワンピース",
  description: "鮮やかな色のボーダーが目を引く半袖ワンピース",
  price: 9900,
  stock: 30
)
product8.image.attach(io: File.open(Rails.root.join('app/assets/images/onepiece1.jpg')), filename: 'onepiece1.jpg')
product8.save!

product9 = Product.new(
  name: "foxco×PBトートバッグ",
  description: "イラストレーターの foxco さんとコラボレーションした日本限定のラウンジウェアコレクションが新登場！",
  price: 4950,
  stock: 30
)
product9.image.attach(io: File.open(Rails.root.join('app/assets/images/bag1.jpg')), filename: 'bag1.jpg')
product9.save!

product10 = Product.new(
  name: "ＭＭトートバッグ",
  description: "Mr. Men Little Miss ×プチバトーのコラボレーショントートバッグ",
  price: 1320,
  stock: 30
)
product10.image.attach(io: File.open(Rails.root.join('app/assets/images/bag2.jpg')), filename: 'bag2.jpg')
product10.save!
