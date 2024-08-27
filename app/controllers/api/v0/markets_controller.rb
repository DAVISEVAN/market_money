class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    markets = Market.all

    render json: MarketSerializer.find(params[:id]), status: :ok
  end
end