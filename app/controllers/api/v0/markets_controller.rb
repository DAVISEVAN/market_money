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
    if invalid_search_params?
      render json: { errors: [{ detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." }] }, status: :unprocessable_entity
    else
      markets = Market.all

      markets = markets.where('state ILIKE ?', "%#{params[:state]}%") if params[:state].present?
      markets = markets.where('city ILIKE ?', "%#{params[:city]}%") if params[:city].present?
      markets = markets.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?

      Rails.logger.debug "Markets found after filtering: #{markets.inspect}"

      render json: MarketSerializer.new(markets).serializable_hash.to_json, status: :ok
    end
  end

  private

  def invalid_search_params?
    city_only = params[:city].present? && params[:state].blank? && params[:name].blank?
    city_and_name = params[:city].present? && params[:state].blank? && params[:name].present?
    
    city_only || city_and_name
  end


end