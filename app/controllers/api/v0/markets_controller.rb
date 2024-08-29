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

  def nearest_atms
    market = Market.find_by(id: params[:id])

    if market
      atms = fetch_nearest_atms(market)

      render json: AtmSerializer.new(atms).serializable_hash.to_json, status: :ok
    else
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:id]}" }] }, status: :not_found
    end
  end

  private

  def invalid_search_params?
    city_only = params[:city].present? && params[:state].blank? && params[:name].blank?
    city_and_name = params[:city].present? && params[:state].blank? && params[:name].present?
    
    city_only || city_and_name
  end

  def fetch_nearest_atms(market)

    connection = Faraday.new('https://api.tomtom.com') do |faraday|
      faraday.headers['X-Api-Key'] = Rails.application.credentials.tom_tom[:key]
      faraday.adapter Faraday.default_adapter
    end

    response = connection.get('/search/2/categorySearch/atm.json', {
      lat: market.lat,
      lon: market.lon,
      radius: 10000,
    })

    if response.success?
      json_response = JSON.parse(response.body)
      json_response['results'].map do |atm|
        {
          name: atm['poi']['name'],
          address: atm['address']['freeformAddress'],
          lat: atm['position']['lat'],
          lon: atm['position']['lon'],
          distance: atm['dist']
        }
      end.sort_by { |atm| atm[:distance] }
    else
      []
    end
  end
end