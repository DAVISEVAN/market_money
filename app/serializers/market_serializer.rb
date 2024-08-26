class MarketSerializer
  def self.format_markets(markets)
    markets.map do |market|
      {
        id: market.id,
        name: market.name,
        street: market.street,
        city: market.city,
        county: market.county,
        state: market.state,
        zip: market.zip,
        lat: market.lat,
        lon: market.lon,
      }
    end
  end
end