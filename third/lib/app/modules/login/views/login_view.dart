import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text("Welcome",
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey)),
              const SizedBox(height: 80),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter email",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter password",
                            border: OutlineInputBorder()),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 70,
              ),
              Obx(() => Container(
                    child: controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.loginUser(
                                    controller.emailController.text,
                                    controller.passwordController.text);
                                final snackBar = SnackBar(
                                    content:
                                        Obx(() => Text(controller.msg.value)),
                                    action: SnackBarAction(
                                        label: "Undo", onPressed: () {}));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(120, 50)),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 20.0),
                            )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
