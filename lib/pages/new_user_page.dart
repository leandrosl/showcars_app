import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

import '../states/authentication_state.dart';

import '../pages/home_page.dart';

class NewUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Text("Novo Usuário"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Padding(
          padding: EdgeInsets.only(top: 24.0),
          child: NewUserForm(),
        ),
      ),
    );
  }
}

class NewUserForm extends StatefulWidget {
  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final _newUserFormKey = GlobalKey<FormState>();

  AuthenticationState _authenticationState;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticationState = Provider.of<AuthenticationState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _newUserFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameTextController,
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
          TextFormField(
            controller: emailTextController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordTextController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              child: Text('Criar Usuário'),
              onPressed: () {
                _authenticationState.createNewUser(
                  nameTextController.text, emailTextController.text, passwordTextController.text)
                  .then((value) {
                    if (Provider.of<AuthenticationState>(context, listen: false).isLogged) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomePage()
                      ));
                    }
                  })
                  .catchError((error) {
                    print(error);
                    showInfoDialog(context, 'Erro', 'Falha ao tentar cadastrar usuário');
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}