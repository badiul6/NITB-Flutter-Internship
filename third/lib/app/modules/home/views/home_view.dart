import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome", style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              
        )),
        const SizedBox(height: 100,),

              GestureDetector(
                onTap: () {
                  Get.toNamed("/login");
                },
                child: Container(
                      height: MediaQuery.sizeOf(context).height*.09,
                      width: double.infinity,
                      decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: const Center(child: Text("Get Started", style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
                      ),)),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
