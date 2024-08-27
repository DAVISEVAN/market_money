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

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.format_vendors([vendor]).first, status: :created
    else
      render json: { errors: [{ detail: vendor.errors.full_messages.to_sentence }] }, status: :bad_request
    end
  end

  def destroy
    vendor = Vendor.find_by(id: params[:id])

    if vendor
      vendor.destroy
      head :no_content
    else
      render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end
