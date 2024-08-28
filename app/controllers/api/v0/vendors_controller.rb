class Api::V0::VendorsController < ApplicationController

  def index
    market = Market.find_by(id: params[:market_id])
    if market
      vendors = market.vendors
      render json: VendorSerializer.new(vendors), status: :ok
    else
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:market_id]}" }] }, status: :not_found
    end
  end

  def show
    vendor = Vendor.find_by(id: params[:id])
    if vendor
      render json: VendorSerializer.new(vendor), status: :ok
    else
      render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
    end
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: { errors: vendor.errors.full_messages.map { |msg| { detail: msg } } }, status: :bad_request
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: :ok
    else
      render json: { errors: format_errors(vendor.errors) }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: :not_found
  end


  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def format_errors(errors)
    errors.full_messages.map { |msg| { detail: msg } }
  end

end