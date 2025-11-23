class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true } # カテゴリ名 (一意制約)
      t.string :color_code                                # UI表示用カラーコード
      
      t.timestamps
    end
  end
end