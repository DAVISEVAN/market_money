class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates_with UniqueMarketVendorValidator
end