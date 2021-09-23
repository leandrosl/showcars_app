import 'package:flutter/material.dart';

import '../repositories/user_repository.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationState extends ChangeNotifier {
  String userName;
  String email;

  bool isLogged;

  final storageKeyUserToken = "user_token";
  final storageKeyUserEmail = "user_email";
  final storageKeyUserName = "user_name";

  FlutterSecureStorage _secureStorage;

  AuthenticationState() {
    _secureStorage = FlutterSecureStorage();

    isLogged = false;

    userName = "";
    email = "";
  }

  Future<void> isHasUserLogged() async {
    isLogged = await _secureStorage.read(key: storageKeyUserName) != null;
    
    if (isLogged) {
      userName = await _secureStorage.read(key: storageKeyUserName);
      email = await _secureStorage.read(key: storageKeyUserEmail);
    }
    
    notifyListeners();
  }

  Future<void> makeLogin(String email, String password) async {
    if (email != null && password != null) {
      try {
        final userCredentials = await UserRepository().signIn(email, password);

        if (userCredentials.containsKey('accessToken')) {
          userName = userCredentials["name"];
          email = userCredentials["email"];

          await _secureStorage.write(
            key: storageKeyUserToken, 
            value: userCredentials["accessToken"],
          );
          await _secureStorage.write(key: storageKeyUserEmail, value: email);
          await _secureStorage.write(key: storageKeyUserName, value: userName);

          isLogged = true;

          notifyListeners();
        }
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  //metodo novousuario
  //TODO: terminar este metodo para novos usuarios
  /*void createNewUser(String name, String email, String password) {
    if (name != null && email != null && password != null) {
      UserRepository().signUp(name, email, password)
        .then((userCredentials) => {

        })
        .catchError((err) => {});
    }
  }*/

  Future<void> logoutUser() async {
    await _secureStorage.delete(key: storageKeyUserToken);
    await _secureStorage.delete(key: storageKeyUserEmail);
    await _secureStorage.delete(key: storageKeyUserName);

    isLogged = false;
    userName = "";
    email = "";

    notifyListeners();
  }

  Future<void> checkTokenStorage() async {
    String token = await _secureStorage.read(key: storageKeyUserToken);
    print("TOKEN NO STORAGE ======>  $token");
  }
}