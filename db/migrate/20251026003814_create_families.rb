class CreateFamilies < ActiveRecord::Migration[7.1]
  def change
    create_table :families do |t|
      t.string :name, null: false, index: { unique: true } # 家庭名 (一意制約)
      t.boolean :is_default, default: false, null: false    # デフォルト設定フラグ
      
      t.timestamps
    end
  end
end