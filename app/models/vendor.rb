class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates :name, :description, :contact_name, :contact_phone, presence: true
  validate :credit_accepted_presence

  private

  def credit_accepted_presence
    if credit_accepted.nil?
      errors.add(:credit_accepted, "can't be blank")
    end
  end
end