require 'rails_helper'

RSpec.describe "Merchant's coupons index page", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: false)
    @coupon2 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, value_type: 0, activated: false)
  end

  describe "When visiting a merchant's coupon index page" do
    describe "I see all coupon names and their amount off" do
      it "displays coupon name and amount off" do
        visit(merchant_coupons_path(@merch))
        
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
      
      it "each name is a link that leads to the coupon show page" do
        visit(merchant_coupons_path(@merch))
        
        within "#coupon_#{@coupon1.id}" do
          expect(page).to have_link(@coupon1.name)
          click_link(@coupon1.name)
        end
        expect(current_path).to eq(merchant_coupon_path(@merch, @coupon1))
        expect(page).to have_content(@coupon1.name)
      end
    end
    
    describe "New Merchant Coupon Link" do
      describe "merchant coupon index page has link to create a new coupon" do
        it "can click a link that leads to the new coupon form" do
          visit(merchant_coupons_path(@merch))

          within "#new_coupon" do
            expect(page).to have_link("Create New Coupon")

            click_link("Create New Coupon")

            expect(current_path).to eq(new_merchant_coupon_path(@merch))
          end
        end
      end
    end
  end
end