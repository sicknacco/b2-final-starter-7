require "rails_helper"

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merch = Merchant.create!(name: "Jim Bob's")
    @coupon1 = @merch.coupons.create!(name: "$10 off", code: "OFF10", value: 10.00, value_type: 1, activated: false)
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value) }
    it { should validate_presence_of(:value_type) }
    it { should allow_value(true).for(:activated) }
    it { should allow_value(false).for(:activated) }
    it { should_not allow_value(nil).for(:activated) }
  end

  describe "Instance Methods" do
    describe "#times_used" do
      it "shows number of times a coupon has been used on successful transactions" do
        test_data
        # require 'pry'; binding.pry
        expect(@coupon1.times_used).to eq(2)
        expect(@coupon2.times_used).to eq(1)
      end
    end
  end
end