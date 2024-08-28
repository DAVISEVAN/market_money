require 'rails_helper'

RSpec.describe "Market Money API" do
  it "can get one market by its id" do
    id = create(:market).id
    
    vendor = create(:vendor)

    market_vendors = MarketVendor.create(market_id: id, vendor_id: vendor.id)

    get "/api/v0/markets/#{id}"

    market = JSON.parse(response.body, symbolize_names: true)

    market_data = market[:data]

    market_attributes = market_data[:attributes]

    expect(response).to be_successful

    expect(market_data).to have_key(:id)
    expect(market_data[:id]).to eq(id.to_s)

    expect(market_data).to have_key(:id)
    expect(market_data[:type]).to eq("market")

    expect(market_attributes).to have_key(:name)
    expect(market_attributes[:name]).to be_a(String)

    expect(market_attributes).to have_key(:street)
    expect(market_attributes[:street]).to be_a(String)

    expect(market_attributes).to have_key(:city)
    expect(market_attributes[:city]).to be_a(String)

    expect(market_attributes).to have_key(:county)
    expect(market_attributes[:county]).to be_a(String)

    expect(market_attributes).to have_key(:state)
    expect(market_attributes[:state]).to be_a(String)
    
    expect(market_attributes).to have_key(:zip)
    expect(market_attributes[:zip]).to be_a(String)

    expect(market_attributes).to have_key(:lat)
    expect(market_attributes[:lat]).to be_a(String)

    expect(market_attributes).to have_key(:lon)
    expect(market_attributes[:lon]).to be_a(String)
    
    expect(market_attributes).to have_key(:vendor_count)
    expect(market_attributes[:vendor_count]).to eq(1)
  end

  it "will not return a market with a invalid id " do
    id = create(:market).id

    vendor = create(:vendor)

    market_vendors = MarketVendor.create(market_id: id, vendor_id: vendor.id)

    get "/api/v0/markets/#{0}"

    expect(response).to be_unsuccessful
    expect(response.status).to eq(404)
    
    markets = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=0")
  end
end