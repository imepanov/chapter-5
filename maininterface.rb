class MainInterface
  def initialize(face)
    @face = face
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
      when 1  #добавить поезд/станцию/маршрут
        @face.create_object
      when 2   # добавить или удалить станцию на маршруте
        puts "Введите название станции"
        name_station = gets.chomp
        puts "Введите номер маршрута"
        number_route = gets.to_i
        if @face.station_exist?(name_station) && @face.route_exist?(number_route)
          begin
            puts "Что вы хотите сделать?"
            puts "1. Удалить"
            puts "2. Добавить"
            a = gets.to_i
          end until a == 1 || a == 2
          if a == 1
            @face.del_station(number_route, name_station)
          else
            @face.add_station(number_route, name_station)
          end
        else
          puts "Убедитесь в существовании станции и маршрута!"
        end

      when 3 #Присвоить маршрут поезду
        puts "Введите номер маршрута"
        number_route = gets.to_i
        puts "Введите номер поезда"
        number_train = gets.to_i
        if @face.train_exist?(number_train) && @face.route_exist?(number_route)
          @face.trains.each do |train|
            train.routes(@face.routes.find { |route| route.number_route == number_route }) if train.number == number_train
          end
          @face.trains.each { |train| puts "Поезду присвоен маршрут #{train.number_route}"  if train.number == number_train }
        else
          puts "Убедитесь в существовании поезда и маршрута!"
        end

      when 4  #Прицепить/отцепить вагон
        puts "Введите номер вагона"
        number_carriage = gets.to_i
        puts "Введите номер поезда"
        number_train = gets.to_i
        if @face.carriage_exist?(number_carriage) && @face.train_exist?(number_train)
          puts "Что вы хотите сделать?"
          puts "1. Прицепить вагон"
          puts "2. отцепить вагон"
          a = gets.to_i
        end until a == 1 || a == 2
          if a == 1
          @face.trains.each do |train|
            train.add_carriage(@face.carriages.find{ |carriage| carriage.number == number_carriage if train.number == number_train })
            end
          else
        @face.trains.each do |train|
          train.remove_carriage(@face.carriages.find { |carriage| carriage.number == number_carriage  if train.number == number_train })
          end
        end
        #else
        #puts "Убедитесь в существовании вагона и поезда"
        #end

      when 5  #Перемещать поезда между станциями
        puts "Введите номер поезда"
        number_train = gets.to_i
        if @face.train_exist?(number_train)
          begin
            puts "Куда вы хотите переместить?"
            puts "1. Вперед"
            puts "2. Назад"
            a = gets.to_i
          end until a == 1 || a == 2
          if a == 1
            @face.trains.each { |train| train.go_next_station if train.number == number_train }
          else
            @face.trains.each { |train| train.go_previous_station if train.number == number_train }
          end
          else
          puts "Номера с таким поездом не существует!"
          end
      when 6  #Cписок всех станций
        puts "Список всех станций:"
        @face.stations.each.with_index(1) { |station, index| puts "Станция № #{index} - #{station.name}" }

      when 7 #Показать все поезда на станции
        puts "Введите название станции"
        name_station = gets.chomp
        if @face.station_exist?(name_station)
          puts "На станции \"#{name_station}\" находятся поезда:"
          @face.stations.each { |station| station.trains.each.with_index(1) { |train, index| puts "#{index}, Поезд - № #{train.number}" if station.name == name_station } }
        else
          puts "Такой станции не существует"
        end
      when 8
        exit
      else
        puts "Выберите число из списка!"
      end
    end
  end
end

