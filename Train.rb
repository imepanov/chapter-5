class Train
  attr_accessor :speed, :trains
  attr_reader :station, :number, :type, :name, :current_index, :route, :number_route
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
  end

  def routes(route)
    @routes = route
    @current_index = 0
    current_station.arrived(self)
  end

  def go_next_station
    current_station.left(self)
    next_station.arrived(self)
  end

  def go_previous_station
    current_station.left(self)
    previous_station.arrived(self)
  end

  def add_carriage(carriage)
    @carriages << carriage
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage)
  end

  protected #данные методы можно вынести в протектед, так как они не предназначены для непосредственного вызова

  def current_station
    @routes.station[(@current_index)]
  end

  def next_station
    if @current_index == (@routes.station.index(-1))
      @routes.station[-1]
    else
      @routes.station[(@current_index += 1)]
    end
  end

  def previous_station
    if @current_index == @routes.station[0]
      @routes.station[0]
    else
      @routes.station[(@current_index -= 1)]
    end
  end

end



