class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    markets = Market.all
    begin
      render json: MarketSerializer.format_markets(markets)
    rescue ActiveRecord::RecordNotFound => exceptions
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
    end
  end
end