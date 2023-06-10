require 'rails_helper'

RSpec.describe "New Coupon Form", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    visit(new_merchant_coupon_path(@merch))
  end

  describe "Creating a new coupon for a merchant" do
    describe "has a form to create a new coupon"
    it "can confirm form elements" do
      expect(page).to have_content("Create New Coupon")
      within "#new_coupon_form" do
        expect(page).to have_field("Name")
        expect(page).to have_field("Code")
        expect(page).to have_field("Value")
        expect(page).to have_field("Value type")
      end
    end
    
    it "can fill in the new coupon form and confirm creation" do
      within "#new_coupon_form" do
        fill_in "Name", with: "Spring Sale"
        fill_in "Code", with: "SPRING50"
        fill_in "Value", with: 0.50
        select "percent", from: "Value type"
        click_button("Create Coupon")
      end
      expect(current_path).to eq(merchant_coupons_path(@merch))
      expect(page).to have_content("Coupon successfully created!")
      expect(page).to have_content("Spring Sale")
      expect(page).to have_content(0.50)
      expect(page).to have_content("percent")
    end

    it "won't create a coupon if merchant has 5 active coupons" do
      @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: true)
      @coupon2 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 0.10, value_type: 0, activated: true)
      @coupon3 = @merch.coupons.create!(name: "Summer Sale", code: "SUMMER", value: 0.25, value_type: 0, activated: true)
      @coupon4 = @merch.coupons.create!(name: "Spring Sale", code: "SPRING", value: 25.00, value_type: 1, activated: true)
      @coupon5 = @merch.coupons.create!(name: "Number 5", code: "NUM5", value: 5.00, value_type: 1, activated: true)

      within "#new_coupon_form" do
        fill_in "Name", with: "Winter $20"
        fill_in "Code", with: "WIN20"
        fill_in "Value", with: 0.20
        select "percent", from: "Value type"
        click_button("Create Coupon")
      end
      expect(current_path).to eq(new_merchant_coupon_path(@merch))
      expect(page).to have_content("Limit 5 active coupons. Please deactivate one before creating another")
    end
  end
end