import 'package:flutter/material.dart';

import 'package:showcars_app/models/category.dart';

import 'package:showcars_app/repositories/category_repository.dart';

class CategoryCarsPage extends StatelessWidget {
  CategoryRepository _repository;
  
  @override
  Widget build(BuildContext context) {
    _repository = CategoryRepository();

    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _repository.getCategories(),
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

            return _categoryCarsList(snapshot.data);
          }
        ),
      ),
    );
  }

  Widget _categoryCarsList(List<Category> categories) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return _listItemCard(categories[index]);
      }
    );
  }

  Widget _listItemCard(Category category) {
    return Card(
      child: Stack(
        children: <Widget>[
          Container(
            height: 120,
          ),
          Positioned.fill(
              child: FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage('http://192.168.0.210:5200/${category.imageUrl}'),
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
    );
  }
}