import 'package:chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SelectedMediaView extends GetView<ChatController> {
  const SelectedMediaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Image.network(
              'https://images.pexels.com/photos/13035386/pexels-photo-13035386.'
                  'jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: MediaQuery.of(context).size.width * 0.17,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0,
                          color:
                              index == 2 ? Colors.green : Colors.transparent)),
                  child: Image.network(
                      fit: BoxFit.fill,
                      'https://images.pexels.com/photos/13035386/pexels-photo-13035386.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load'),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 40),
                  backgroundColor: const Color.fromARGB(255, 77, 139, 79)),
              onPressed: () {},
              child: const Text('Send'))
        ],
      ),
    );
  }
}
