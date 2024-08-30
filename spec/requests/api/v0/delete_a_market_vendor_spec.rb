require 'rails_helper'

RSpec.describe 'MarketVendors API', type: :request do
  # Helper method to parse JSON responses
  def json
    JSON.parse(response.body)
  end

  let!(:market) { create(:market) }
  let!(:vendor) { create(:vendor) }
  let!(:market_vendor) { create(:market_vendor, market: market, vendor: vendor) }

  describe 'DELETE /api/v0/market_vendors' do
    context 'when the request is valid' do
      before do
        delete '/api/v0/market_vendors', 
               params: { market_id: market.id, vendor_id: vendor.id }.to_json,
               headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end

      it 'removes the market vendor association' do
        expect(response).to have_http_status(:no_content)
        expect(MarketVendor.find_by(market_id: market.id, vendor_id: vendor.id)).to be_nil
      end
    end

    context 'when the market vendor association does not exist' do
      before do
        delete '/api/v0/market_vendors', 
               params: { market_id: 4233, vendor_id: 11520 }.to_json,
               headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
      end

      it 'returns a not found status' do
        expect(response).to have_http_status(:not_found)
        expect(json['errors'].first['detail']).to eq('No MarketVendor with market_id=4233 AND vendor_id=11520 exists')
      end
    end
  end
end