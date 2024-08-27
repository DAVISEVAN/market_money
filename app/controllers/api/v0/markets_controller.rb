class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    render json: Market.find(params[:id])
    markets = Market.all

    render json: MarketSerializer.format_markets(markets), status: :ok
  end
end