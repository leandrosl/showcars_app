import 'package:flutter/material.dart';
import 'package:showcars_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:showcars_app/states/authentication_state.dart';

void main() => runApp(ShowCarsApp());

class ShowCarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationState>(
      create: (_) => AuthenticationState(),
      child: MaterialApp(
        title: 'ShowCars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}