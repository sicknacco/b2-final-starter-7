require 'rails_helper'

RSpec.describe "Merchant's coupons index page", type: :feature do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, activated: false)
    @coupon1 = @merch.coupons.create!(name: "10% off", code: "TAKE10PER", value: 10.00, activated: false)
  end

  describe "When visiting a merchant's coupon index page" do
    describe "I see all coupon names and their amount off" do
      it "can display name and the amount off for each" do

      end

      it "each coupon name is a link that leads to its show page" do
        
      end
    end
  end
end