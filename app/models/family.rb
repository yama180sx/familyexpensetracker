class Family < ApplicationRecord
  # 家庭は複数の品目を持つ
  has_many :items, dependent: :restrict_with_exception # Itemレコードが残っている場合、Familyの削除を許可しない

  # バリデーション
  validates :name, presence: true, uniqueness: true
end