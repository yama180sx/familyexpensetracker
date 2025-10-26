class CreateReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :receipts do |t|
      t.date :transaction_date
      t.string :store_name
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :image_url

      t.timestamps
    end
  end
end
