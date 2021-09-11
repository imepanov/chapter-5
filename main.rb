require_relative 'train'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'passengercarriage'
require_relative 'cargocarriage'
require_relative 'interface'
require_relative 'maininterface'

face = Interface.new
main_interface = MainInterface.new(face)
main_interface.start


