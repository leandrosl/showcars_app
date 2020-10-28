import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/manufactor.dart';

class ManufactorRepository {
  Future<List<Manufactor>> getManufactors() async {
    Response response = await Dio().get('http://192.168.0.210:5200/manufactors');
    return response.data.map<Manufactor>((m) => Manufactor.fromJson(m)).toList();
  }
}