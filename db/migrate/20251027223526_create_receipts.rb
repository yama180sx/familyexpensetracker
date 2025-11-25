class CreateReceipts < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|
      t.string :image_url # S3などへの画像パス（Active Storageを使う場合は不要になる可能性あり）

      # 基本情報
      t.date :transaction_date, null: false # 取引日
      t.string :store_name
      
      # 金額情報
      # 金額の計算精度を確保するため DECIMAL 型を使用
      t.decimal :total_amount, precision: 10, scale: 2, null: false 

      t.timestamps
    end
  end
end