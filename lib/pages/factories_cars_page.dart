import 'package:flutter/material.dart';

import '../bloc/factory_bloc.dart';
import '../models/manufactor.dart';
import '../pages/cars_list_page.dart';

import '../utils.dart';

class FactoriesCarsPage extends StatefulWidget {
  @override
  _FactoriesCarsPageState createState() => _FactoriesCarsPageState();
}

class _FactoriesCarsPageState extends State<FactoriesCarsPage> { 
  FactoryBloc factoryBloc;

  @override
  void initState() {
    factoryBloc = FactoryBloc();
    factoryBloc.getFactories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: factoryBloc.getFactories,
          child: StreamBuilder<List<Manufactor>>(
            stream: factoryBloc.factories,
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
                  child: Text("Nenhum fabricante encontrado"),
                );
              }
        
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(snapshot.data.length, (index) {
                  var manufactor = snapshot.data[index];
        
                  return _FactoriesGridItem(
                    manufactor: manufactor,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CarsListPage(
                          idFactory: int.tryParse(manufactor.id),
                          pageTitle: 'Carros - ${manufactor.name}',
                        ),
                      ));
                    },
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    factoryBloc.dispose();
    super.dispose();
  }
}

class _FactoriesGridItem extends StatelessWidget {
  final Manufactor manufactor;
  final Function onTap;

  _FactoriesGridItem({this.manufactor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              child: (manufactor.logoUrl != null) ? Image.network(
                '$apiBaseUrl/${manufactor.logoUrl}',
                fit: BoxFit.contain,
              ) : Image(
                image: AssetImage('assets/images/laferrari.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: Text(
                manufactor.name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}