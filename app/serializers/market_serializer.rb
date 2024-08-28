class MarketSerializer

  # def self.format_market(market)
  #   {
  #     data: {
  #       id: market.id,
  #       type: "market",
  #       attributes: {
  #         name: market.name,
  #         street: market.street,
  #         city: market.city,
  #         county: market.county,
  #         state: market.state,
  #         zip: market.zip,
  #         lat: market.lat,
  #         lon: market.lon,
  #         vendor_count: market.vendors.count
  #       }
  #     }
  #   }
  # end

  include JSONAPI::Serializer

  attributes :name, :street, :city, :county, :state, :zip, :lat, :lon

  attribute :vendor_count do |market|
    market.vendor_count
  end
end