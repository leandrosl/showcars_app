import 'package:flutter/material.dart';

import '../models/car.dart';

import '../utils.dart';

class CarDetailPage extends StatelessWidget {
  final Car car;

  CarDetailPage({this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${car.manufactor.name} ${car.name}"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Column(
                    children: [
                      (car.imageUrl != null) ? Image(
                        image: NetworkImage('$apiBaseUrl/${car.imageUrl}'),
                        fit: BoxFit.cover,
                      ) : Image(
                        image: AssetImage('assets/images/tesla.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 20.0,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 4,
                    right: 16,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.manufactor.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        car.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
              _CarDetailsSection(
                icon: Icons.star,
                body: [
                  ..._carSectionItem(
                    "Horsepower",
                    car.horsepower != null ? "${car.horsepower} HP" : "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Engine Type", 
                    car.engineType ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Torque", 
                    car.torque ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Gearbox",
                    car.gearbox ?? "",
                  ),
                ],
              ),
              
              _CarDetailsSectionDivider(),
              
              _CarDetailsSection(
                icon: Icons.star,
                body: [
                  ..._carSectionItem(
                    "Top Speed", 
                    car.topSpeed ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "0-100 Time", 
                    car.acceleration0To100 ?? "",
                  ),
                ],
              ),

              _CarDetailsSectionDivider(),

              _CarDetailsSection(
                icon: Icons.star,
                body: [
                  ..._carSectionItem(
                    "Doors",
                    car.numberDoors ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Width",
                    car.width ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Height",
                    car.height ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Length",
                    car.length ?? "",
                  ),
                  SizedBox(height: 16.0),
                  ..._carSectionItem(
                    "Weight", 
                    car.weight ?? "",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _carSectionItem(String title, String description) {
    return [
      Text(
        title,
        style: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
      ),
      Text(
        description,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
    ];
  }
}

class _CarDetailsSection extends StatelessWidget {
  final IconData icon;
  final List<Widget> body;

  _CarDetailsSection({this.icon, this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        right: 16.0,
        left: 16.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 16.0),
            child: Icon(
              icon,
              color: Colors.grey[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: body,
          ),
        ],
      ),
    );
  }
}

class _CarDetailsSectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: Colors.grey[300],
      indent: 75,
      endIndent: 75,
    );
  }
}