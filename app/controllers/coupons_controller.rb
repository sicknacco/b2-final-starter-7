class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.new
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)

    if @merchant.five_active_coupons?
      flash[:alert] = "Limit 5 active coupons. Please deactivate one before creating another"
      redirect_to new_merchant_coupon_path(@merchant)
    elsif 
      @coupon.save
      flash[:notice] = "Coupon successfully created!"
      redirect_to merchant_coupons_path(@merchant)
    elsif
      @coupon.errors[:code].include?("has already been taken")
      flash[:notice] = "That code is already taken, sorry!"
      redirect_to new_merchant_coupon_path(@merchant)
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:notice] = "Please complete all fields"
    end
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])

    if @merchant.five_active_coupons?
      flash[:alert] = "Limit 5 active coupons. Please deactivate one before creating another"
    elsif
      @coupon.activated == true
      @coupon.update(activated: false)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    else
      @coupon.activated == false
      @coupon.update(activated: true)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :value, :value_type, :merchant_id, :activated)
  end
end