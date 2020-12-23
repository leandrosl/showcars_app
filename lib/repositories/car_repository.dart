import 'dart:async';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/car.dart';

import '../utils.dart';

class CarRepository {
  Future<List<Car>> getCarsByFactory(String factoryId) async {
    Response response = await Dio().get("$apiBaseUrl/cars/manufactors/$factoryId");
    return response.data.map<Car>((car) => Car.fromJson(car)).toList();
  }

  Future<List<Car>> getCarsByCategory(String categoryId) async {
    Response response = await Dio().get("$apiBaseUrl/cars/categories/$categoryId");
    return response.data.map<Car>((car) => Car.fromJson(car)).toList();
  }
}