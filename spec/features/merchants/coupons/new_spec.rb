require 'rails_helper'

RSpec.describe "New Coupon Form", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, activated: false)
    @coupon2 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, activated: false)
  end

  describe "Creating a new coupon for a merchant" do
    describe "has a form to create a new coupon"
    it "can confirm form elements" do
      visit(new_merchant_coupon_path(@merch))

      expect(page).to have_content("Create New Coupon")
      expect(page).to have_field("Name")
      expect(page).to have_field("Code")
      expect(page).to have_field("Value")
      expect(page).to have_field("Value type")
    end
  end
end