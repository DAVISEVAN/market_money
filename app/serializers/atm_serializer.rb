class AtmSerializer
  include JSONAPI::Serializer

  set_type :atm

  attributes  :name, :address, :lat, :lon, :distance
end