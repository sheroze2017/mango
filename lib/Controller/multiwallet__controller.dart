import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class multiwallet extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loaddata();
  }

  var datakey = [].obs;
  var dataadd = [].obs;
  final _storage = FlutterSecureStorage();

  Future<void> loaddata() async {
    String? a = await _storage.read(key: 'datakey');
    List<dynamic> listofa = await jsonDecode(a!);
    datakey.assignAll(listofa);
    datakey.refresh();
    // print(datakey);
    //  print(dataadd);

    String? b = await _storage.read(key: 'dataadd');
    List<dynamic> listofb = await jsonDecode(b!);
    dataadd.assignAll(listofb);
    dataadd.refresh();
  }
}
