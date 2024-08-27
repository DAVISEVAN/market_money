class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    markets = Market.all

    render json: MarketSerializer.formate_markets(Market.find(params[:id])), status: :ok
  end
end