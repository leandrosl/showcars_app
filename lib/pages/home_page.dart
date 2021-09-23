import 'package:flutter/material.dart';

import 'package:showcars_app/pages/about_app_page.dart';
import 'package:showcars_app/pages/factories_cars_page.dart';
import 'package:showcars_app/pages/favorite_cars_page.dart';
import 'package:showcars_app/pages/category_cars_page.dart';
import 'package:showcars_app/pages/new_user_page.dart';

import 'package:showcars_app/states/authentication_state.dart';

import 'package:provider/provider.dart';

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
      drawer: _HomePageDrawer(),
      body: SafeArea(
        child: Container(
          child: _currentPage,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexPage,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.android),
            label: "CATEGORIAS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android),
            label: "FABRICANTES",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "FAVORITOS",
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

class _HomePageDrawer extends StatefulWidget {
  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<_HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    print(context.watch<AuthenticationState>().userName);
    print(context.watch<AuthenticationState>().email);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: context.watch<AuthenticationState>().userName != "" ? Text(
                    context.watch<AuthenticationState>().userName,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ) : Container(width: 10.0, height: 10.0),
                ),
                FittedBox(
                  child: context.watch<AuthenticationState>().email != "" ? Text(
                    context.watch<AuthenticationState>().email,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ) : Container(width: 10.0, height: 10.0),
                ),
              ],
            ),
          ),
          !context.watch<AuthenticationState>().isLogged ? Align(
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              child: Text('Fazer Login'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewUserPage(),
              )),
            ),
          ) : Column(
            children: [
              Text('Está logado'),
              ElevatedButton(
                child: Text('Logout'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NewUserPage(),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}