class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find_by(id: params[:market_id])

    if market
      vendors = market.vendors
      render json: VendorSerializer.format_vendors(vendors), status: :ok
    else
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:market_id]}" }] }, status: :not_found
    end
  end
end
