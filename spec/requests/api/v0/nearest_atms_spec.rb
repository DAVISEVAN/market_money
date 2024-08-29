require 'rails_helper'

RSpec.describe 'Get Nearest ATMs (Real API Request)', type: :request do

def json
    JSON.parse(response.body)
end

let!(:market) { create(:market, lat: '35.0844', lon: '-106.6504') }

  describe 'GET /api/v0/markets/:id/nearest_atms' do
    context 'when the market exists and a real API request is made' do
      it 'returns a list of ATMs near the market from the real TomTom API' do
        get "/api/v0/markets/#{market.id}/nearest_atms"

        expect(response).to have_http_status(:ok)

        
        expect(json['data']).not_to be_empty

        first_atm = json['data'].first['attributes']
        expect(first_atm['name']).not_to be_nil
        expect(first_atm['address']).not_to be_nil
        expect(first_atm['lat']).not_to be_nil
        expect(first_atm['lon']).not_to be_nil
        expect(first_atm['distance']).not_to be_nil
      end
    end

    context 'when the market does not exist' do
      it 'returns a 404 error' do
        get '/api/v0/markets/123123123123/nearest_atms'

        expect(response).to have_http_status(:not_found)
        expect(json['errors'].first['detail']).to eq("Couldn't find Market with 'id'=123123123123")
      end
    end
  end
end
