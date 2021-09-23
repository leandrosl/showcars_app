import 'package:flutter/material.dart';
import 'package:showcars_app/states/authentication_state.dart';
import 'package:provider/provider.dart';

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
        child: Center(
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

  AuthenticationState _authState;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authState = Provider.of<AuthenticationState>(context, listen: false);
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
                _authState.makeLogin(emailTextController.text, passwordTextController.text);
                Future.delayed(Duration(seconds: 2), () => _authState.checkTokenStorage());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              child: Text('Fazer logout'),
              onPressed: () async {
                await _authState.logoutUser();
                Future.delayed(Duration(seconds: 2), () => _authState.checkTokenStorage());
              },
            ),
          ),
        ],
      ),
    );
  }
}