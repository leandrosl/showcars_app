import 'package:flutter/material.dart';
import 'package:showcars_app/pages/home_page.dart';

void main() => runApp(ShowCarsApp());

class ShowCarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowCars',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}