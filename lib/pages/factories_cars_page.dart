import 'package:flutter/material.dart';

import 'package:showcars_app/models/manufactor.dart';

import 'package:showcars_app/pages/cars_list_page.dart';

import 'package:showcars_app/repositories/car_repository.dart';
import 'package:showcars_app/repositories/manufactor_repository.dart';

import '../utils.dart';

class FactoriesCarsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManufactorRepository _manufactorRepository = ManufactorRepository();
    CarRepository _carRepository = CarRepository();

    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _manufactorRepository.getManufactors(),
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
                    _carRepository.getCarsByFactory(manufactor.id).then((cars) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CarsListPage(
                          cars: cars,
                          pageTitle: 'Carros - ${manufactor.name}',
                        ),
                      ));
                    });
                  },
                );
              }),
            );
          },
        ),
      ),
    );
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