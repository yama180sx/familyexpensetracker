class Category < ApplicationRecord
  # カテゴリは複数の品目を持つ
  has_many :items, dependent: :restrict_with_exception 
  
  # バリデーション
  validates :name, presence: true, uniqueness: true
end