class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code, unique: true
      t.decimal :value
      t.references :merchant, null: false, foreign_key: true
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
