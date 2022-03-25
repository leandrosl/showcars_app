import 'package:flutter/material.dart';

import '../models/category.dart';
import '../bloc/category_bloc.dart';
import '../utils.dart';

import './cars_list_page.dart';

class CategoryCarsPage extends StatefulWidget {
  @override
  _CategoryCarsPageState createState() => _CategoryCarsPageState();
}

class _CategoryCarsPageState extends State<CategoryCarsPage> {
  final categoryBloc = CategoryBloc();

  @override
  void initState() {
    categoryBloc.getCategories();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: categoryBloc.getCategories,
          child: StreamBuilder<List<Category>>(
            stream: categoryBloc.categories,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text("Falha ao tentar acessar o servidor"),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.length == 0) {
                return Center(
                  child: Text("Nenhuma categoria encontrada"),
                );
              }
        
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = snapshot.data[index];
        
                  return _CategoryListItem(
                    category: category,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CarsListPage(
                          idCategory: int.tryParse(category.id),
                          pageTitle: 'Carros - ${category.name}',
                        ),
                      ));
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

  @override
  void dispose() {
    categoryBloc.dispose();
    super.dispose();
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