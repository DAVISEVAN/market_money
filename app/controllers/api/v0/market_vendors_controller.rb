class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_vendor = MarketVendor.new(market_vendor_params)
    if market_vendor.save
      render json: { message: 'Successfully added vendor to market' }, status: :created
    else
      render json: { errors: market_vendor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
    if market_vendor
      market_vendor.destroy
      head :no_content
    else
      render json: { errors: ["MarketVendor association not found"] }, status: :not_found
    end
  end

  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end
