class Api::V0::MarketsController < ApplicationController

  def index
    markets = Market.all
    render json: MarketSerializer.new(markets).serializable_hash.to_json, status: :ok
  end

  def show
    market = Market.find(params[:id])
    render json: MarketSerializer.new(market).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:id]}" }] }, status: :not_found
  end

  def search
    if params[:state].present? || params[:state].empty? && params[:name].present?
      render json: MarketSerializer.new
    elsif params[:city].present? || params[:name].present? && params[:city].present? && params[:state].empty?
      
    end
  end

  private 

  def market_params
    params.require(:market).permit(:name, :state, :city)
  end
end