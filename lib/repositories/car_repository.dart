import 'dart:async';

import 'package:dio/dio.dart';
import 'package:showcars_app/models/car.dart';

class CarRepository {
  Future<List<Car>> getCarsByFactory(String factoryId) async {
    Response response = await Dio().get("http://192.168.0.210:5200/cars/$factoryId");
    return response.data.map<Car>((car) => Car.fromJson(car)).toList();
  }
}