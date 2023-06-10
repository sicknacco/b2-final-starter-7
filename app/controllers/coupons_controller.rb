class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    # require 'pry'; binding.pry
    @coupon = Coupon.new
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)
    if @merchant.coupons.count >= 5
      flash[:alert] = "Limit 5 active coupons. Please deactivate one before creating another"
      redirect_to new_merchant_coupon_path(@merchant)
    elsif 
      @coupon.save
      flash[:notice] = "Coupon successfully created!"
      redirect_to merchant_coupons_path(@merchant)
    else
      render :new
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :value, :value_type, :merchant_id)
  end
end