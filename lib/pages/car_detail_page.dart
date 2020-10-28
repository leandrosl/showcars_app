import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tesla Model S"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(),
                  Image(
                    image: AssetImage('assets/images/tesla.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
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
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: EdgeInsets.only(
                  top: 24.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tesla",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Model S",
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
                  ..._carSectionItem("Horsepower", "503 HP"),
                  SizedBox(height: 16.0),
                  ..._carSectionItem("Engine Type", "Eletric"),
                ],
              ),
              
              _CarDetailsSectionDivider(),
              
              _CarDetailsSection(
                icon: Icons.star,
                body: [
                  ..._carSectionItem("Top Speed", "305Km/h"),
                  SizedBox(height: 16.0),
                  ..._carSectionItem("0-100 Time", "3.6s"),
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