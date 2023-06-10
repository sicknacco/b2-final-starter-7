require 'rails_helper'

RSpec.describe "Merchant's coupons index page", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, activated: false)
    @coupon1 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 10.00, activated: false)
  end

  describe "When visiting a merchant's coupon index page" do
    describe "I see all coupon names and their amount off" do
      it "displays coupon name and amount off" do
        visit(merchant_coupons_path(@merchant1))

        within "#coupon_#{@coupon1.id}" do
          expect(page).to have_link(@coupon1.name)
          expect(page).to have_content("Coupon Name: #{@coupon1.name}")
          expect(page).to have_content("Coupon Amount Off: #{@coupon1.value}")
          expect(page).to_not have_link(@coupon2.name)
          expect(page).to_not have_content("Coupon Amount Off: #{@coupon2.value}")
          expect(page).to_not have_content("Coupon Name: #{@coupon2.name}")
        end
        
        within "#coupon_#{@coupon2.id}" do
          expect(page).to have_link(@coupon2.name)
          expect(page).to have_content("Coupon Name: #{@coupon2.name}")
          expect(page).to have_content("Coupon Amount Off: #{@coupon2.value}")
          expect(page).to_not have_link(@coupon1.name)
          expect(page).to_not have_content("Coupon Amount Off: #{@coupon1.value}")
          expect(page).to_not have_content("Coupon Name: #{@coupon1.name}")
        end
      end
      
      xit "each name is a link that leads to the coupon show page" do
        within "#coupon_#{@coupon1.id}" do
          expect(page).to have_link(@coupon1.name)

          click_link(@coupon1.name)
          expect(current_path).to eq(merchant_coupon_path(@merc, @coupon1))
        end
      end
    end
  end
end