class Interface
  attr_reader :stations, :trains, :routes, :carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end
  def start
    loop do
      puts "1. Создать станцию, поезд, маршрут или вагон"
      puts "2. Добавить или удалить станцию в маршруте"
      puts "3. Назначить маршрут поезду"
      puts "4. Прицепить/отцепить вагон"
      puts "5. Переместить поезд по маршруту"
      puts "6. Показать все станции"
      puts "7. Показать все поезда на станции"
      puts "8. Выход"

      a = gets.to_i
      case a
      when 1
        create_object    #создать станцию/поезд/маршрут/вагон
      when 2
        push_station   #добавить станцию
      when 3
        add_route    #добавить поезд на маршрут
      when 4
        push_carriage   #добавить вагон к поезду
      when 5
        drive_train   # перемещать поезда между станциями
      when 6
        all_station   #список всех станции
      when 7
        all_train_on_station  #Показать все поезда на станции
      when 8
        exit    # Выход
      else
        puts "Выберите число из списка!"
      end
    end
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
      route.del_station(@stations.find { |st| st.name == name_station}) if route.number_route == number_route
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
        @trains.each.with_index(1) { |train, index| puts "Поезд #{index} - #{train.number}, тип поезда: " + output_type(train.type) }
      end
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

  def push_station   # добавить или удалить станцию на маршруте
    puts "Введите название станции"
    name_station = gets.chomp
    puts "Введите номер маршрута"
    number_route = gets.to_i
    if station_exist?(name_station) && route_exist?(number_route)
      begin
        puts "Что вы хотите сделать?"
        puts "1. Удалить"
        puts "2. Добавить"
        a = gets.to_i
      end until a == 1 || a == 2
      if a == 1
        del_station(number_route, name_station)
      else
        add_station(number_route, name_station)
      end
    else
      puts "Убедитесь в существовании станции и маршрута!"
    end
  end

  def add_route  #Присвоить маршрут поезду
    puts "Введите номер маршрута"
    number_route = gets.to_i
    puts "Введите номер поезда"
    number_train = gets.to_i
    if train_exist?(number_train) && route_exist?(number_route)
      trains.each do |train|
        train.routes(routes.find { |route| route.number_route == number_route }) if train.number == number_train
      end
      trains.each { |train| puts "Поезду присвоен маршрут #{train.number_route}"  if train.number == number_train }
    else
      puts "Убедитесь в существовании поезда и маршрута!"
    end
  end

  def push_carriage  #Прицепить/отцепить вагон
    puts "Введите номер вагона"
    number_carriage = gets.to_i
    puts "Введите номер поезда"
    number_train = gets.to_i
    if carriage_exist?(number_carriage) && train_exist?(number_train)
      puts "Что вы хотите сделать?"
      puts "1. Прицепить вагон"
      puts "2. отцепить вагон"
      a = gets.to_i
    end until a == 1 || a == 2
    if a == 1
      trains.each do |train|
        train.add_carriage(carriages.find{ |carriage| carriage.number == number_carriage if train.number == number_train })
        puts "Прицеплен Вагон с номером #{carriage.number}"
      end
    else
      trains.each do |train|
        train.remove_carriage(carriages.find { |carriage| carriage.number == number_carriage  if train.number == number_train })
        puts "Вагон отцеплен от поезда"
      end
    end
  end
    #else
      #puts "Убедитесь в существовании вагона и поезда"
      #end
  def drive_train  #Перемещать поезда между станциями
    puts "Введите номер поезда"
    number_train = gets.to_i
    if train_exist?(number_train)
      begin
        puts "Куда вы хотите переместить?"
        puts "1. Вперед"
        puts "2. Назад"
        a = gets.to_i
      end until a == 1 || a == 2
      if a == 1
        trains.each { |train| train.go_next_station if train.number == number_train }
      else
        trains.each { |train| train.go_previous_station if train.number == number_train }
      end
    else
      puts "Номера с таким поездом не существует!"
    end
  end

  def all_station  #Cписок всех станций
    puts "Список всех станций:"
    stations.each.with_index(1) { |station, index| puts "Станция № #{index} - #{station.name}" }
  end

  def all_train_on_station #Показать все поезда на станции
    puts "Введите название станции"
    name_station = gets.chomp
    if station_exist?(name_station)
      puts "На станции \"#{name_station}\" находятся поезда:"
      stations.each { |station| station.trains.each.with_index(1) { |train, index| puts "#{index}, Поезд - № #{train.number}" if station.name == name_station } }
    else
      puts "Такой станции не существует"
    end
  end

  def exit
    exit
  end

  protected   # анные методы можно вынести в протектед, так как они не предназначены для непосредственного вызова
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
end