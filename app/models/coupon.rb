class Coupon < ApplicationRecord
  belongs_to :merchant
  # has_many :items, through: :merchant
  # has_many :invoice_items, through: :items
  has_many :invoice
end