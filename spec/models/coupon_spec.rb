require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { has_one :invoice }
  end

  describe "validations" do

  end
end