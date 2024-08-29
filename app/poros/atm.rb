class Atm
  attr_reader :id, :name, :address, :lat, :lon, :distance

  def initialize(data)
    @id = nil
    @name = data['poi']['name']
    @address = data['address']['freeformAddress']
    @lat = data['position']['lat']
    @lon = data['position']['lon']
    @distance = data['dist']
  end
end