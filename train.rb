class Train
  attr_accessor :speed, :trains
  attr_reader :station, :speed, :number, :type, :name, :current_index, :route, :number_route
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
    if @speed == 0
      @carriages << carriage
      puts "Прицеплен Вагон с номером #{carriage.number}"
    else
      puts "Поезд в движении"
    end
  end
  def remove_carriage(carriage)
    if @speed == 0 && !@carriages.empty?
      @carriages.delete(carriage)
      puts "Вагон отцеплен от поезда"
    else
      puts "Поезд в движении"
    end
  end

  protected #данные методы можно вынести в протектед, так как они не предназначены для непосредственного вызова

  def current_station
    @routes.station[(@current_index)]
  end

  def next_station
    if @current_index == (@routes.station.index(-1))
      puts "end of the route"
      @routes.station[-1]
    else
      @routes.station[(@current_index += 1)]
    end
  end

  def previous_station
    if @current_index == @routes.station[0]
      puts "begin of the route"
      @routes.station[0]
    else
      @routes.station[(@current_index -= 1)]
    end
  end

end



