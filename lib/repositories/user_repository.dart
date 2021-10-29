import 'dart:async';

import 'package:dio/dio.dart';
import 'package:showcars_app/utils.dart';

class UserRepository {
  Future<dynamic> signIn(String email, String password) async {
    try {
      Map<String, dynamic> formData = {
        "email": email,
        "password": password
      };

      Response response = await Dio().post('$apiBaseUrl/auth/signin', data: formData);

      if (response.statusCode == 200) {
        return response.data;
      }

      throw Exception("Api fetch error");
    } catch (err) {
      throw Exception('$err');
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    Map<String, dynamic> formData = {
      "name": name,
      "email": email,
      "password": password
    };

    Response response = await Dio().post('$apiBaseUrl/auth/signup', data: formData);

    if (response.statusCode == 201) {
      return true;
    }

    print(response.data['message']);
    return false;
  }
}