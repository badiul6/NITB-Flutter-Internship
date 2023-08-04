import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var pageCount = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }
  setPageCount(int num){
    pageCount.value=num;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
