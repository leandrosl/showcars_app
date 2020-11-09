import 'dart:async';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/car.dart';

import '../utils.dart';

class CarRepository {
  Future<List<Car>> getCarsByFactory(String factoryId) async {
    Response response = await Dio().get("$apiBaseUrl/cars/$factoryId");
    return response.data.map<Car>((car) => Car.fromJson(car)).toList();
  }

  Future<List<Car>> getCarsByCategory(String categoryId) async {
    Response response = await Dio().get("$apiBaseUrl/categories/cars/$categoryId");
    return response.data.map<Car>((car) => Car.fromJson(car)).toList();
  }
}