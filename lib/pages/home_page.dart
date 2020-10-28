import 'package:flutter/material.dart';
import 'package:showcars_app/pages/about_app_page.dart';
import 'package:showcars_app/pages/factories_cars_page.dart';
import 'package:showcars_app/pages/favorite_cars_page.dart';
import 'package:showcars_app/pages/category_cars_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexPage = 0;
  List<Widget> _pages = [CategoryCarsPage(), FactoriesCarsPage(), FavoriteCarsPage()];
  Widget _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShowCars"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => AboutAppPage(),
            )),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: _currentPage,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.android),
            title: Text(
              "CATEGORIAS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android),
            title: Text(
              "FABRICANTES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text(
              "FAVORITOS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndexPage = selectedIndex;
      _currentPage = _pages[selectedIndex];
    });
  }
}