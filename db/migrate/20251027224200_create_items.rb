class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      # 関連付け (外部キー)
      # レシートと家庭は必須のため null: false を設定
      t.references :receipt, null: false, foreign_key: true
      t.references :family, null: false, foreign_key: true
      t.references :category, foreign_key: true # カテゴリは未分類を許容するため null を許可

      # 品目情報
      t.string :name, null: false
      # 金額の計算精度を確保するため DECIMAL 型を使用
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end