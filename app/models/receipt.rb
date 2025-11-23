class Receipt < ApplicationRecord
  # レシートは複数の品目を持つ
  has_many :items, dependent: :destroy # Receipt削除時、関連するItemも一緒に削除する
  
  # Active Storageを使用してレシート画像を添付
  has_one_attached :image 
  
  # バリデーション
  validates :transaction_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # imageのpresence validationは、OCR失敗時の手動入力も考慮し、一旦は省略
end