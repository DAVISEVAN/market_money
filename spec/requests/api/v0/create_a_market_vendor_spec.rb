require 'rails_helper'

RSpec.describe 'MarketVendors API', type: :request do
  def json
    JSON.parse(response.body)
  end

  describe 'POST /api/v0/market_vendors' do
    let(:market) { create(:market) }
    let(:vendor) { create(:vendor) }

    context 'when the request is valid' do
      before { post '/api/v0/market_vendors', params: { market_vendor: { market_id: market.id, vendor_id: vendor.id } } }

      it 'creates a market vendor' do
        expect(response).to have_http_status(:created)
        expect(json['message']).to eq('Successfully added vendor to market')
      end
    end

    context 'when the market_id is invalid' do
      before { post '/api/v0/market_vendors', params: { market_vendor: { market_id: -1, vendor_id: vendor.id } } }

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
        expect(json['errors'].first['detail']).to include('Market must exist')
      end
    end

    context 'when the vendor_id is invalid' do
      before { post '/api/v0/market_vendors', params: { market_vendor: { market_id: market.id, vendor_id: -1 } } }

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
        expect(json['errors'].first['detail']).to include('Vendor must exist')
      end
    end

    context 'when the association already exists' do
      before do
        create(:market_vendor, market: market, vendor: vendor)
        post '/api/v0/market_vendors', params: { market_vendor: { market_id: market.id, vendor_id: vendor.id } }
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors'].first['detail']).to include('Market vendor association between market')
      end
    end
  end
end