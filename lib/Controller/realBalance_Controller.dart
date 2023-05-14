import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyController extends GetxController {
  RxDouble myNumber = 0.0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   Timer.periodic(Duration(seconds: 5), (timer) {
  //     // Call your function here
  //     getNumber();
  //   });
  // }

  Future getNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myNumber.value = prefs.getDouble('balance')!;
    //a.value=await myNumber.value.toString();
  }
}
