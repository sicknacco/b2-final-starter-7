class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :name, presence: true
  validates :value, presence: true, numericality: true
  validates :value_type, presence: true
  validates :activated, inclusion: [true, false]
  validates :code, presence: true, uniqueness: true

  enum value_type: {"percent": 0, "dollar": 1}
end