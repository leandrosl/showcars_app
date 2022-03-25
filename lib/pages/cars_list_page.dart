import 'package:flutter/material.dart';

import '../models/car.dart';
import '../pages/car_detail_page.dart';
import '../bloc/list_cars_bloc.dart';

import '../utils.dart';

class CarsListPage extends StatefulWidget {
  final String pageTitle;
  final int idCategory;
  final int idFactory;

  CarsListPage({this.idCategory, this.idFactory, this.pageTitle});

  @override
  _CarsListPageState createState() => _CarsListPageState();
}

class _CarsListPageState extends State<CarsListPage> {
  ListCarsBloc _listCarsBloc;

  @override
  void initState() {
    _listCarsBloc = ListCarsBloc();
    _retrieveCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: RefreshIndicator(
        onRefresh: _retrieveCars,
        child: StreamBuilder<List<Car>>(
          stream: _listCarsBloc.cars,
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
                child: Text("Nenhum carro encontrada"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _CarListPageItem(car: snapshot.data[index]);
              },
            );
          }
        ),
      ),
    );
  }

  Future<void> _retrieveCars() async {
    if (widget.idCategory != null) {
      await _listCarsBloc.getCarsByCategory(widget.idCategory);
    } else if (widget.idFactory != null) {
      await _listCarsBloc.getCarsByFactory(widget.idFactory);
    }
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
                image: NetworkImage('$apiBaseUrl/${car.imageUrl}'),
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
            ),
          ],
        ),
      ),
    );
  }
}