class Interface
  attr_reader :stations, :trains, :routes, :carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def create_object
    show_menu
    a = gets.to_i
    case a
    when 1
      create_station
    when 2
      create_trains
    when 3
      create_routes
    when 4
      create_carriages
    else
      puts "выберите число из списка!"
    end
  end

  def add_station(number_route, name_station)
    @routes.each do |route|
      route.add_station(@stations.find { |st| st.name == name_station}) if route.number_route == number_route
    end
  end

  def del_station(number_route, name_station)
    @routes.each do |route|
      route.delete_station(@stations.find { |st| st.name == name_station}) if route.number_route == number_route
    end
  end

  def station_exist?(name_station)
    @stations.find { |station| station.name == name_station }
  end

  def route_exist?(number)
    @routes.find { |route| route.number_route == number}
  end

  def carriage_exist?(number_carriage)
    @carriages.find { |carriage| carriage.number == number_carriage}
  end

  def train_exist?(number_train)
    @trains.find { |train| train.number == number_train }
  end

  def output_type(type)
    if type == 'C'
      'грузовой'
    else
      'пассажирский'
    end
  end

  def show_menu
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать маршрут"
    puts "4. Создать вагон"
  end

  def create_station
    loop do
      puts "Введите название станции или нажмите Enter, чтобы выйти"
      name_station = gets.chomp
      break if name_station == ''
      if station_exist?(name_station)
        puts "Станция с таким названием уже существует!"
      else
        @stations << Station.new(name_station)
      end
      @stations.each.with_index(1) { |station, index| puts "Станция #{index} - \"#{station.name}\""}
    end
  end

  def create_trains
    loop do
      puts "Введите номер поезда или нажмите Enter, чтобы выйти"
      number_train = gets.to_i
      if number_train == 0 || train_exist?(number_train)
        break if number_train == 0
        puts "Поезд с таким номером уже существует!"
      else
        begin
          puts "Введите 1 - если поезд грузовой"
          puts "Введите 2 - если поезд пассажирский"
          b = gets.to_i
        end until b == 1 || b == 2
        if b == 1
          @trains << CargoTrain.new(number_train)
        else
          @trains << PassengerTrain.new(number_train)
        end
      end
      @trains.each.with_index(1) { |train, index| puts "Поезд #{index} - #{train.number}, тип поезда: " + output_type(train.type) }
    end
  end

  def create_routes
    loop do
      puts "Введите номер маршрута или нажмите Enter, чтобы выйти"
      number_route = gets.to_i
      if number_route == 0 || route_exist?(number_route)
        break if number_route == 0
        puts "Маршрут с таким номером уже существует!"
        @routes.each.with_index(1) {
          |route, index| puts "Маршрут #{index} - #{route.number_route}, первая станция \"#{route.stations[0].name}\", последняя станция \"#{route.stations[-1].name}\""
        }
      else
        puts "Введите название первой станции"
        one_station = gets.chomp
        puts "Введите название последней станции"
        end_station = gets.chomp
        if !station_exist?(one_station) || !station_exist?(end_station)
          puts "Убедитесь в существовании введеных станций!"
        else
          @routes << Route.new(@stations.find { |st| st.name == one_station }, @stations.find { |st| st.name == end_station }, number_route)
          @routes.each.with_index(1) { |route, index| puts "Маршрут #{index} - #{route.number_route}, первая станция \"#{route.station[0].name}\", последняя станция \"#{route.station[-1].name}\"" }
        end
      end
    end
  end

  def create_carriages
    loop do
      puts "Введите номер вагона или нажмите Enter, чтобы выйти"
      number_carriage = gets.to_i
      if number_carriage == 0 || carriage_exist?(number_carriage)
        break if number_carriage == 0
        puts "Вагон с таким номером уже существует!"
        @carriages.each.with_index(1) { |carriage, index| puts "Вагон #{index} - #{carriage.number}, находится на станции \"#{carriage.station.name}\", тип вагона: " + output_type(carriage.type) }
      else
        begin
          puts "Выберите тип вагона"
          puts "1. Грузовой"
          puts "2. Пассажирский"
          a = gets.to_i
        end until a == 1 || a == 2
        if a == 2
          @carriages << PassengerCarriage.new(number_carriage)
        else
          @carriages << CargoCarriage.new(number_carriage, "C")
        end
        @carriages.each.with_index(1) { |carriage, index| puts "Вагон #{index} - #{carriage.number}, тип вагона: " + output_type(carriage.type) }
      end
    end
  end
end