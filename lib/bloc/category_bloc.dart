import 'dart:async';

import 'package:showcars_app/models/category.dart';

import '../repositories/category_repository.dart';

class CategoryBloc {
  final _categoryRepository = CategoryRepository();

  final _categoriesStreamController = StreamController<List<Category>>();
  Stream<List<Category>> get categories => _categoriesStreamController.stream.asBroadcastStream();

  Future<void> getCategories() async {
    try {
      var categories = await _categoryRepository.getCategories();
      _categoriesStreamController.sink.add(categories);
    } catch (e) {
      _categoriesStreamController.sink.addError(e);
    }
  }

  void dispose() {
    _categoriesStreamController.close();
  }
}