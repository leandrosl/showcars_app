import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/new_user_page.dart';
import '../pages/home_page.dart';

import '../states/authentication_state.dart';

import '../utils.dart';

class LoginUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Text("Fazer Login"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: _LoginUserForm(),
            ),
            const SizedBox(height: 48.0),
            TextButton(
              child: Text("Criar Conta"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NewUserPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginUserForm extends StatefulWidget {
  @override
  _LoginUserFormState createState() => _LoginUserFormState();
}

class _LoginUserFormState extends State<_LoginUserForm> {
  AuthenticationState authenticationState;

  final _loginUserFormKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authenticationState = Provider.of<AuthenticationState>(context, listen: false);
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginUserFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailTextController,
            decoration: const InputDecoration(
              labelText: 'Email',
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
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: ElevatedButton(
              child: Text('Entrar'),
              onPressed: () {
                authenticationState
                  .makeLogin(emailTextController.text, passwordTextController.text)
                  .then((value){
                    if (Provider.of<AuthenticationState>(context, listen: false).isLogged) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomePage()
                      ));
                    }
                  })
                  .catchError((e) {
                    print(e);
                    showInfoDialog(context, 'Erro', 'Falha ao tentar fazer login');
                  });      
              },
            ),
          ),
        ],
      ),
    );
  }
}