class Api::V0::MarketsController < ApplicationController

  # def show 
  #   render json: MarketSerializer.format_market(Market.find(params[:id]))
  # end
  
  ## Evan ##
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

  # private
  
  # def not_found_response(exception)
  #   render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
  #     .serialize_json, status: :not_found
  # end
end