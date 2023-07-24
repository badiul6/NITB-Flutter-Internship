import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:third/app/data/models/login_response.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString msg = "".obs;

  Future<LoginResponse> loginUser(String email, String password) async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isLoading.value = false;
      msg.value = "Login Successful";

      // print(response.body.toString());
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      isLoading.value = false;
      msg.value = "Login Failed: ${response.body}";

      // print(response.body.toString());

      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login User');
    }
  }
}
