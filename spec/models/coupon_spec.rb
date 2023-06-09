require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    # it { should have_many(:items).through(:merchant) }
    # it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoice) }
  end

  describe "validations" do

  end
end