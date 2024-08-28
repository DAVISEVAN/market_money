# require 'rails_helper'

# RSpec.describe "Market Money API" do
#   # before :each do
#   #   @market1 = Market.create(:market, city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market' )
#   #   @market2 = Market.create(:market, city: 'Santa Fe', state: 'New Mexico', name: 'Santa Fe Market'  )
#     # Try doing let if before each is not working 
#   let!(:market1) { create(:market, city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market') }
#   let!(:market2) { create(:market, city: 'Santa Fe', state: 'New Mexico', name: 'Santa Fe Market') }

#   describe "GET /api/v0/markets/search" do
#     context "when valid parameters are present" do
#       it "returns correct market" do

#         get "/api/v0/markets/search", params{city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers Market'}

#         market = JSON.parse(response.body, symbolize_names: true)

#         expect(response).to have_http_status(:ok)

#         expect(json["data"].length).to eq(1)

#         expect(json["data"].first.["attributes"]["name"]).to eq("Nob Hill Growers Market")

#       end

#       it "returns an empty array when there are no markets" do
#         get "/api/v0/markets/search", params{city: 'ASDF', state: 'ASDF', name: 'ASDF'}

#         expect(response).to have_http_status(:ok)

#         expect(json["data"]).to be_empty

#       end
#     end

#     context "when invalid parameters are sent" do
#       it "cannot get a market when searched by city (422 error)" do
#         get "/api/v0/markets/search", params{city: 'Albuquerque' }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(json["errors"].first["detail"]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
#       end

#       it "returns a 422 error when searching by only city and name without state" do
#         get "/api/v0/markets/search", params{city: 'Albuquerque', name: 'Nob Hill Growers Market' }

#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(json["errors"].first["detail"]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
#       end
#     end
#   end
# end

require 'rails_helper'

RSpec.describe 'Market Search API', type: :request do

  let!(:market1) { create(:market, city: 'Albuquerque', state: 'New Mexico', name: 'Nob Hill Growers\' Market') }
  let!(:market2) { create(:market, city: 'Santa Fe', state: 'New Mexico', name: 'Santa Fe Market') }

  describe "GET /api/v0/markets/search" do
    context 'when valid parameters are provided' do
      it 'returns the correct market(s)' do
        get '/api/v0/markets/search', params: { city: 'albuquerque', state: 'new mexico', name: 'Nob hill' }
        expect(response).to have_http_status(:ok)
        expect(json['data'].length).to eq(1)
        expect(json['data'].first['attributes']['name']).to eq('Nob Hill Growers\' Market')
      end
      it 'returns an empty array when no markets match' do
        get '/api/v0/markets/search', params: { city: 'los angeles', state: 'california', name: 'Nonexistent Market' }
        expect(response).to have_http_status(:ok)
        expect(json['data']).to be_empty
      end
    end
    context 'when invalid parameters are provided' do
      it 'returns a 422 error for city only' do
        get '/api/v0/markets/search', params: { city: 'albuquerque' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors'].first['detail']).to eq('Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.')
      end
      it 'returns a 422 error for city and name without state' do
        get '/api/v0/markets/search', params: { city: 'albuquerque', name: 'Nob Hill' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors'].first['detail']).to eq('Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.')
      end
    end
  end
end