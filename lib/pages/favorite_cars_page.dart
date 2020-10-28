import 'package:flutter/material.dart';

class FavoriteCarsPage extends StatefulWidget {
  @override
  _FavoriteCarsPageState createState() => _FavoriteCarsPageState();
}

class _FavoriteCarsPageState extends State<FavoriteCarsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _FavoriteCar(
            manufactor: "Pagani",
            model: "Zonda",
          ),
          _FavoriteCar(
            manufactor: "Ferrari",
            model: "LaFerrari",
          ),
        ],
      ),
    );
  }
}

class _FavoriteCar extends StatelessWidget {
  final String manufactor;
  final String model;

  _FavoriteCar({this.manufactor, this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/tesla.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manufactor ?? "AA",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(model ?? "BB"),
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 24,
                right: 8,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}