class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :receipt, null: false, foreign_key: true
      t.references :family, null: false, foreign_key: true
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
