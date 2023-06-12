require 'rails_helper'

RSpec.describe "Coupon's Show Page", type: :feature do
  
  describe "Merchant Coupon Index page links to show" do
    it "each name is a link that leads to that coupon's show page" do
      @merch = Merchant.create!(name: "Jim Bob's")
      @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: false)
      @coupon2 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, value_type: 0, activated: false)
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

  describe "Coupon show page details" do
    it "shows coupon name, code, value, status, and number of times it's been used" do
      test_data
      visit(merchant_coupon_path(@merchant1, @coupon1))
      
      expect(page).to have_content("#{@coupon1.name} Show Page")
      expect(page).to have_content("Code: #{@coupon1.code}")
      expect(page).to have_content("Value: #{@coupon1.value}")
      expect(page).to have_content("Value Type: #{@coupon1.value_type}")
      expect(page).to have_content("Coupon Activated?: #{@coupon1.activated}")
      expect(page).to have_content("Times Used: #{@coupon1.times_used}")
    end
  end
  
  describe "Deactivate coupon button" do
    it "has a button to deactivate a coupon" do
      test_data
      visit(merchant_coupon_path(@merchant1, @coupon1))

      expect(page).to have_content("Coupon Activated?: true")
      expect(page).to have_button("Deactivate #{@coupon1.name}")

      click_button("Deactivate #{@coupon1.name}")

      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
      expect(page).to have_content("Coupon Activated?: false")
    end
  end

  describe "Activate coupon button" do
    it "has a button to activate a coupon" do
      test_data
      visit(merchant_coupon_path(@merchant1, @coupon3))

      expect(page).to have_content("Coupon Activated?: false")
      expect(page).to have_button("Activate #{@coupon3.name}")

      click_button("Activate #{@coupon3.name}")

      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon3))
      expect(page).to have_content("Coupon Activated?: true")
    end
  end
  
  describe "Sad path to prevent coupon activation if there are 5 active coupons" do
    it "will flash a message when trying to activate a sixth coupon" do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @coupon1 = @merchant1.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: true)
      @coupon2 = @merchant1.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, value_type: 0, activated: true)
      @coupon3 = @merchant1.coupons.create!(name: "Summer Sale", code: "SUMMER", value: 0.25, value_type: 0, activated: true)
      @coupon4 = @merchant1.coupons.create!(name: "Spring Sale", code: "SPRING", value: 25.00, value_type: 1, activated: true)
      @coupon5 = @merchant1.coupons.create!(name: "Number 5", code: "NUM5", value: 5.00, value_type: 1, activated: true)
      @coupon6 = @merchant1.coupons.create!(name: "Golden Ticket", code: "GOLDEN", value: 50.00, value_type: 1, activated: false)
      
      visit(merchant_coupon_path(@merchant1, @coupon6))
      click_button("Activate #{@coupon6.name}")
      
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon6))
      expect(page).to have_button("Activate #{@coupon6.name}")
      expect(page).to have_content("Limit 5 active coupons. Please deactivate one before activating another")
    end
  end
end