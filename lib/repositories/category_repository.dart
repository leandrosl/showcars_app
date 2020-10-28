import 'dart:async';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/category.dart';

class CategoryRepository {
  Future<List<Category>> getCategories() async {
    Response response = await Dio().get('http://192.168.0.210:5200/categories');
    return response.data.map<Category>((c) => Category.fromJson(c)).toList();
  }
}