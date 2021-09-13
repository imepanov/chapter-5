class Route
  attr_reader :routes, :trains, :station, :name, :current_index, :number_route
  def initialize(start, finish, number)   #  все методы дожны быть public
    @station = [start, finish]
    @number_route = number
  end

  def add_station(station)
    @station.insert(-2, station)
  end

  def del_station(station)
    @station.delete(station)
  end

end
