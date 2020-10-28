import 'package:flutter/material.dart';

class CarsListPage extends StatefulWidget {
  final String factoryName;

  CarsListPage({this.factoryName});

  @override
  _CarsListPageState createState() => _CarsListPageState();
}

class _CarsListPageState extends State<CarsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars - ${widget.factoryName}'),
      ),
      body: Column(
        children: [
          _CarListPageItem(),
        ],
      ),
    );
  }
}

class _CarListPageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
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
                  "Tesla",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  "Model S",
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