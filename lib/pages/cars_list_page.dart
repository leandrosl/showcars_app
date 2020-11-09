import 'package:flutter/material.dart';

import 'package:showcars_app/models/car.dart';

import 'package:showcars_app/pages/car_detail_page.dart';

class CarsListPage extends StatelessWidget {
  final String pageTitle;
  final List<Car> cars;

  CarsListPage({this.cars, this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Container(
        child: (cars == null || cars.length == 0) ? Center(
          child: Text("Nenhum carro encontrado"),
        ) : ListView.builder(
          itemCount: cars.length,
          itemBuilder: (BuildContext context, int index) {
            return _CarListPageItem(car: cars[index]);
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
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => CarDetailPage(car: car),
      )),
      child: Container(
        height: 160.0,
        padding: EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            (car.imageUrl != null) ? Positioned.fill(
                child: Image(
                image: NetworkImage('http://192.168.0.210:5200/${car.imageUrl}'),
                fit: BoxFit.cover,
              ),
            ) : Image(
              image: AssetImage('assets/images/tesla.jpg'),
            ),
            Positioned.fill(
              child: Container(
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
                child: Container(),
              ),
            ),
            Positioned(
              top: 32,
              right: 16,
              child: Text(
                car.manufactor.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),

            Positioned(
              top: 58,
              right: 16,
              child: Text(
                car.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}