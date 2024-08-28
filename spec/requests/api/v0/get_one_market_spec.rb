require 'rails_helper'

RSpec.describe "Market Money API" do
  it "can get one market by its id" do
    id = create(:market).id
    
    vendor = create(:vendor)

    market_vendors = MarketVendor.create(market_id: id, vendor_id: vendor.id)

    get "/api/v0/markets/#{id}"

    market = JSON.parse(response.body, symbolize_names: true)

    market_data = market[:data]

    expect(response).to be_successful
    
    #how to reach through market[:data]

    expect(market_data).to have_key(:id)
    expect(market_data[:id]).to eq(id)

    expect(market_data).to have_key(:name)
    expect(market_data[:name]).to be_a(String)

    expect(market_data).to have_key(:street)
    expect(market_data[:street]).to be_a(String)

    expect(market_data).to have_key(:city)
    expect(market_data[:city]).to be_a(String)

    expect(market_data).to have_key(:county)
    expect(market_data[:county]).to be_a(String)

    expect(market_data).to have_key(:state)
    expect(market_data[:state]).to be_a(String)
    
    expect(market_data).to have_key(:zip)
    expect(market_data[:zip]).to be_a(String)

    expect(market_data).to have_key(:lat)
    expect(market_data[:lat]).to be_a(String)

    expect(market_data).to have_key(:lon)
    expect(market_data[:lon]).to be_a(String)
    
    expect(market_data).to have_key(:vendor_count)
    expect(market_data[:vendor_count]).to eq(1)
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
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=1")
  end
end