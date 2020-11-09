import 'dart:async';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/manufactor.dart';

import '../utils.dart';

class ManufactorRepository {
  Future<List<Manufactor>> getManufactors() async {
    Response response = await Dio().get('$apiBaseUrl/manufactors');
    return response.data.map<Manufactor>((m) => Manufactor.fromJson(m)).toList();
  }
}