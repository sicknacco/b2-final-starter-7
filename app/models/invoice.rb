class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def rev_with_discount
    subtotal = total_revenue
    if coupon.present? && coupon.activated == true
      discount = coupon_discount(subtotal)
      subtotal - discount
    end
  end

  def coupon_discount(subtotal)
    if coupon.value_type == 'percent'
      coupon.value * subtotal
    else
      coupon.value
    end
  end
end
