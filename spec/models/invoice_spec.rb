require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:coupon).optional }
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end

    it ".coupon_discount" do
      test_data
      expected1 = 10 # < invoice_1 discount
      subtotal1 = 900 # <invoice_1 subtotal
      expected2 = 20 # <invoice_3 discount 10% or 0.10
      subtotal2 = 200 # <invoice_3 subtotal
      expect(@invoice_1.coupon_discount(subtotal1)).to eq(expected1)
      expect(@invoice_3.coupon_discount(subtotal2)).to eq(expected2)
    end

    it ".rev_with_discount" do
      test_data
      expect(@invoice_1.rev_with_discount).to eq(890)
      expect(@invoice_3.rev_with_discount).to eq(180)
    end
  end
end
