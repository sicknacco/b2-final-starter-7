class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :value_type, presence: true
  validates :activated, inclusion: [true, false]
  validates :code, presence: true, uniqueness: true

  enum value_type: {"percent": 0, "dollar": 1}
end