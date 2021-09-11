class PassengerTrain < Train
  def initialize(number_of_train)
    super(number_of_train, 'P')
  end

  def add_carriage(carriage)
    if carriage.type == @type
      super
    else
      puts "У поезда и вагона разные типы"
    end
  end
end