import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Center(
          child: InkWell(
            onTap: () {
              
              Get.toNamed(Routes.CHAT);
            },
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.blue,
                gradient: const LinearGradient(colors: [Colors.green, Colors.blue])
              ),
              alignment: Alignment.center,
              child: const Text(
                'ChatApp',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
