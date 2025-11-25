# db/seeds.rb

puts 'Seeding Master Data...'

# ----------------------------------------------------------
# 1. Family (家庭) の初期データ投入
# ----------------------------------------------------------
# Family.find_or_create_by! を使用することで、既にデータが存在しても重複作成を防ぐ
my_family = Family.find_or_create_by!(name: '自分の家庭') do |f|
  f.is_default = true # デフォルト家庭として設定
end

daughter_family = Family.find_or_create_by!(name: '娘の家庭') do |f|
  f.is_default = false
end

# ----------------------------------------------------------
# 2. Category (品目カテゴリ) の初期データ投入
# ----------------------------------------------------------
categories = {}
['食費', '日用品', '交通費', '娯楽費', 'その他'].each do |name|
  categories[name.to_sym] = Category.find_or_create_by!(name: name)
end

puts 'Master Data Seeding Completed.'
puts 'Seeding Transaction Data (Test Receipts and Items)...'

# ----------------------------------------------------------
# 3. テスト用レシートデータの投入
# ----------------------------------------------------------

# --- レシート 1: 完全に分類されたデータ (自分の家庭) ---
receipt1 = Receipt.find_or_create_by!(
  transaction_date: Date.today,
  store_name: 'スーパーA',
  total_amount: 1550.00
) do |r|
  r.image_url = 'test_receipt_001.jpg'
end

receipt1.items.destroy_all # 実行のたびに重複しないように古いアイテムを削除

receipt1.items.create!([
  # family_idを指定しているため、指定した家庭に分類される
  { name: '牛乳', price: 250.00, category: categories[:食費], family: my_family },
  { name: '歯ブラシ', price: 300.00, category: categories[:日用品], family: my_family },
  { name: 'お菓子', price: 1000.00, category: categories[:娯楽費], family: my_family }
])


# --- レシート 2: デフォルト家庭への自動割り当てテスト (family_idを省略) ---
receipt2 = Receipt.find_or_create_by!(
  transaction_date: Date.today - 7.days,
  store_name: 'ドラッグストアB',
  total_amount: 980.00
) do |r|
  r.image_url = 'test_receipt_002.jpg'
end

receipt2.items.destroy_all

receipt2.items.create!([
  # family: nil なので、Itemモデルの before_validation コールバックにより '自分の家庭' (is_default: true) に自動で割り当てられる
  { name: 'パン', price: 400.00, category: categories[:食費] },
  { name: '消毒液', price: 580.00, category: categories[:日用品] }
])

# --- レシート 3: 娘の家庭への分類と未分類カテゴリテスト ---
receipt3 = Receipt.find_or_create_by!(
  transaction_date: Date.today - 30.days,
  store_name: '駅前カフェ',
  total_amount: 1200.00
) do |r|
  r.image_url = 'test_receipt_003.jpg'
end

receipt3.items.destroy_all

receipt3.items.create!([
  { name: '切符代', price: 700.00, category: categories[:交通費], family: daughter_family },
  # category: nil なので、Itemモデルで optional: true にしているため保存でき、「未分類」となる
  { name: '書籍', price: 500.00, family: daughter_family }
])


puts 'Transaction Data Seeding Completed.'
puts "---"
puts "デフォルト家庭: #{my_family.name} (ID: #{my_family.id})"
puts "娘の家庭: #{daughter_family.name} (ID: #{daughter_family.id})"
puts "全レシート件数: #{Receipt.count}"
puts "全品目件数: #{Item.count}"