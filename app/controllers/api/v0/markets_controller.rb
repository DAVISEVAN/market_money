class Api::V0::MarketsController < ApplicationController
  def index
  end

  def show 
    markets = Market.all
    begin
      render json: MarketSerializer.format_markets(markets)
    rescue ActiveRecord::RecordNotFound => exceptions
      render json: {
        errors: [
          {
            status: "404", 
            title: exception.message
          }
        ]
      }, status: :not_found
    end
  end
end