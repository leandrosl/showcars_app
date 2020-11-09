import 'dart:async';

import 'package:dio/dio.dart';

import 'package:showcars_app/models/category.dart';

import '../utils.dart';

class CategoryRepository {
  Future<List<Category>> getCategories() async {
    Response response = await Dio().get('$apiBaseUrl/categories');
    return response.data.map<Category>((c) => Category.fromJson(c)).toList();
  }
}