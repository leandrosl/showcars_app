import 'package:flutter/material.dart';
import 'package:showcars_app/models/car.dart';
import 'package:showcars_app/repositories/car_repository.dart';

class CarsListPage extends StatelessWidget {
  final String factoryName;
  final String factoryId;

  final CarRepository _repository = CarRepository();

  CarsListPage({this.factoryName, this.factoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars - $factoryName'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _repository.getCarsByFactory(factoryId),
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
                child: Text("Nenhum carro encontrado"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _CarListPageItem(car: snapshot.data[index]);
              }
            );
          },
        ),
      ),
    );
  }
}

class _CarListPageItem extends StatelessWidget {
  final Car car;

  _CarListPageItem({this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      padding: EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          (car.imageUrl != null) ? Image(
            image: NetworkImage('http://192.168.0.210:5200/${car.imageUrl}'),
            fit: BoxFit.cover,
          ) : Image(
            image: AssetImage('assets/images/tesla.jpg'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.manufactor.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  car.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}