import 'dart:async';

import '../models/car.dart';
import '../repositories/car_repository.dart';

class ListCarsBloc {
  final _carRepository = CarRepository();

  final _listCarsStreamController = StreamController<List<Car>>();
  Stream<List<Car>> get cars => _listCarsStreamController.stream.asBroadcastStream();

  Future<void> getCarsByFactory(int idFactory) async {
    try {
      var cars = await _carRepository.getCarsByFactory(idFactory.toString());
      _listCarsStreamController.sink.add(cars);
    } catch (e) {
      _listCarsStreamController.sink.addError(e);
    }
  }

  Future<void> getCarsByCategory(int idCategory) async {
    try {
      var cars = await _carRepository.getCarsByCategory(idCategory.toString());
      _listCarsStreamController.sink.add(cars);
    } catch (e) {
      _listCarsStreamController.sink.addError(e);
    }
  }

  void dispose() {
    _listCarsStreamController.close();
  }
}