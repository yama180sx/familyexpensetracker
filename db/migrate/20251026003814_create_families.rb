class CreateFamilies < ActiveRecord::Migration[8.0]
  def change
    create_table :families do |t|
      t.string :name
      t.boolean :is_default

      t.timestamps
    end
  end
end
