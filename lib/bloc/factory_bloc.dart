import 'dart:async';

import '../models/manufactor.dart';
import '../repositories/manufactor_repository.dart';

class FactoryBloc {
  final _manufactorRepository = ManufactorRepository();

  final _manufactorStreamController = StreamController<List<Manufactor>>();
  Stream<List<Manufactor>> get factories => _manufactorStreamController.stream.asBroadcastStream();

  Future<void> getFactories() async {
    try {
      var factories = await _manufactorRepository.getManufactors();
      _manufactorStreamController.sink.add(factories);
    } catch (e) {
      _manufactorStreamController.sink.addError(e);
    }
  }

  void dispose() {
    _manufactorStreamController.close();
  }
}