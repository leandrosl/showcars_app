import 'dart:async';

import 'package:flutter/material.dart';

import 'package:showcars_app/models/category.dart';

import 'package:showcars_app/repositories/car_repository.dart';
import 'package:showcars_app/repositories/category_repository.dart';

import 'cars_list_page.dart';

import '../utils.dart';

class CategoryCarsPage extends StatefulWidget {
  @override
  _CategoryCarsPageState createState() => _CategoryCarsPageState();
}

class _CategoryCarsPageState extends State<CategoryCarsPage> {
  CategoryRepository _categoryRepository = CategoryRepository();
  CarRepository _carRepository = CarRepository();

  Future<List<Category>> _categories;

  @override
  void initState() {
    getCategories();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: getCategories,
          child: FutureBuilder(
            future: _categories,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text("Falha ao tentar acessar o servidor"),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("Nenhuma categoria encontrada"),
                );
              }
        
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Category _category = snapshot.data[index];
        
                  return _CategoryListItem(
                    category: _category,
                    onTap: () {
                      showLoadingDialog(context, 'carregando');
                      _carRepository.getCarsByCategory(_category.id).then((cars) {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CarsListPage(
                            cars: cars,
                            pageTitle: 'Carros - ${_category.name}',
                          ),
                        ));
                      });
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getCategories() async {
    setState(() {
      _categories = _categoryRepository.getCategories();
    });
  }
}

class _CategoryListItem extends StatelessWidget {
  final Category category;
  final Function onTap;

  _CategoryListItem({this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              height: 120,
            ),
            Positioned.fill(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('$apiBaseUrl/${category.imageUrl}'),
                  placeholder: AssetImage('assets/images/tesla.jpg'),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.6),
                ),
              ), 
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        elevation: 4,
      ),
    );
  }
}