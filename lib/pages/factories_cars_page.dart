import 'package:flutter/material.dart';

import 'package:showcars_app/models/manufactor.dart';

import 'package:showcars_app/pages/cars_list_page.dart';

import 'package:showcars_app/repositories/manufactor_repository.dart';

class FactoriesCarsPage extends StatelessWidget {
  ManufactorRepository repository;

  @override
  Widget build(BuildContext context) {
    repository = ManufactorRepository();

    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: repository.getManufactors(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text("Falha ao tentar acessar o servidor"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Nenhum fabricante encontrado"),
              );
            }

            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(snapshot.data.length, (index) {
                return _gridItemCard(
                  context: context,
                  manufactor: snapshot.data[index],
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget _gridItemCard({@required BuildContext context, @required Manufactor manufactor}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CarsListPage(
              factoryName: manufactor.name,
              factoryId: manufactor.id,
            ),
        ));
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              child: (manufactor.logoUrl != null) ? Image.network(
                'http://192.168.0.210:5200/${manufactor.logoUrl}',
                fit: BoxFit.contain,
              ) : Image(
                image: AssetImage('assets/images/laferrari.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: Text(
                manufactor.name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}