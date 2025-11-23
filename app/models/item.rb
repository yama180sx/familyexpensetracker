class Item < ApplicationRecord
  # 関連付け
  belongs_to :receipt
  belongs_to :family
  # Category IDは未設定(未分類)を許容するため optional: true を設定
  belongs_to :category, optional: true 

  # バリデーション
  validates :name, presence: true
  # 金額は正の値である必要がある
  validates :price, presence: true, numericality: { greater_than: 0 } 

  # コールバック: レコード作成前のバリデーション時にデフォルト家庭を自動設定する
  before_validation :set_default_family, on: :create

  private

  # 要件F-104: レコード作成時にfamily_idが空ならis_default=trueのFamily IDを設定する
  def set_default_family
    # family_idが既に設定されている場合はスキップ
    return if self.family_id.present?

    default_family = Family.find_by(is_default: true)
    
    if default_family
      # デフォルト家庭が見つかった場合
      self.family_id = default_family.id
    else
      # デフォルト家庭がDBに存在しない場合はエラーとし、保存を阻止する
      errors.add(:family_id, "デフォルト家庭が設定されていません。")
    end
  end
end