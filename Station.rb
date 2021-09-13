class Station
attr_reader :type, :trains, :name, :stations, :start, :finish, :current_index, :next_station, :previous_station
  def initialize(name)  #  все методы дожны быть public
    @name = name
    @trains = []
  end

  def arrived(train)
    @trains << train
  end

  def left(train)
    @trains.delete(train)
  end

end
