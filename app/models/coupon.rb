class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :value, presence: true, numericality: true
  validates :value_type, presence: true
  validates :activated, inclusion: [true, false]
  validates :code, presence: true, uniqueness: true

  enum value_type: {"percent": 0, "dollar": 1}

  def times_used
    # require 'pry'; binding.pry
    Coupon.joins(invoices: :transactions)
          .where(transactions: { result: 1 })
          .count
  end
end