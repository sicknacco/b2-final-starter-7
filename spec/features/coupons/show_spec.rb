require 'rails_helper'

RSpec.describe "Coupon's Show Page", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: false)
    @coupon2 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, value_type: 0, activated: false)
  end

  describe "Merchant Coupon Index page links to show" do
    it "each name is a link that leads to that coupon's show page" do
      visit(merchant_coupons_path(@merch))

      within "#coupon_#{@coupon1.id}" do
        expect(page).to have_link(@coupon1.name)
        click_link(@coupon1.name)
      end
      expect(current_path).to eq(merchant_coupon_path(@merch, @coupon1))
      expect(page).to have_content(@coupon1.name)
      expect(page).to_not have_content(@coupon2.name)
      
      visit(merchant_coupons_path(@merch))

      within "#coupon_#{@coupon2.id}" do
        expect(page).to have_link(@coupon2.name)
        click_link(@coupon2.name)
      end
      expect(current_path).to eq(merchant_coupon_path(@merch, @coupon2))
      expect(page).to have_content(@coupon2.name)
      expect(page).to_not have_content(@coupon1.name)
    end
  end
end