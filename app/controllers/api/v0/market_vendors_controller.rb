class Api::V0::MarketVendorsController < ApplicationController

  def create
    market_vendor = MarketVendor.new(market_vendor_params)

    if market_vendor.save
      render json: { message: "Successfully added vendor to market" }, status: :created
    else
      render json: { errors: format_errors(market_vendor.errors) }, status: determine_status(market_vendor.errors)
    end
  end

  def destroy
    
    data = JSON.parse(request.body.read)
    market_vendor = MarketVendor.find_by(market_id: data['market_id'], vendor_id: data['vendor_id'])

    if market_vendor
      market_vendor.destroy
      head :no_content # 204 status
    else
      render json: { errors: [{ detail: "No MarketVendor with market_id=#{data['market_id']} AND vendor_id=#{data['vendor_id']} exists" }] }, status: :not_found
    end
  end


  private

  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

  def format_errors(errors)
    errors.full_messages.map { |msg| { detail: msg } }
  end

  def determine_status(errors)
    if errors[:market].any? || errors[:vendor].any?
      :not_found
    elsif errors[:base].any?
      :unprocessable_entity
    else
      :bad_request
    end
  end
end
