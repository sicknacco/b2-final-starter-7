class AddValueTypeToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :value_type, :integer
  end
end
