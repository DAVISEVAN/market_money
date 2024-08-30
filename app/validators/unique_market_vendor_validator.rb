class UniqueMarketVendorValidator < ActiveModel::Validator
  def validate(record)
    if MarketVendor.exists?(market_id: record.market_id, vendor_id: record.vendor_id)
      record.errors.add(:base, "Market vendor association between market with market_id=#{record.market_id} and vendor_id=#{record.vendor_id} already exists")
    end
  end
end
