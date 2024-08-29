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
      market = Market.where(search_market_params)
      render json: MarketSerializer.new(market).serializable_hash.to_json, status: :ok
    elsif params[:city].present? || params[:name].present? && params[:city].present? && params[:state].empty?
      rescue ActiveRecord::RecordNotFound
        render json: { errors: [{ detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." }] }, status: :unprocessable_entity
    end
  end

  private 

  def search_market_params
    params.require(:market).permit(:name, :state, :city)
  end
end