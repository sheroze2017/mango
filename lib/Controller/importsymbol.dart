import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Model/importtoken_model.dart';

class symbolController extends GetxController {
  final _storage = FlutterSecureStorage();
  var isLoading = true.obs;
  RxString a = 'Symbol Name'.obs;
  RxString outputData = RxString('Symbol Name');

  void clearOutputData() {
    outputData.value = '';
  }

  void fetchData(String rpc, String wallet, String token) async {
    importToken tokenData;

    isLoading(true);
    try {
      String? d = await _storage.read(key: 'symbol');
      List<dynamic> listOfd = await jsonDecode(d!);
      var response = await http.get(
        Uri.parse(
            'https://sbgwallet.io:9000/api/imptoken?rpc=$rpc&wallet=$wallet&token=$token'),
      );
      if (response.statusCode == 200) {
        tokenData = await importToken.fromJson(jsonDecode(response.body));

        outputData.value = tokenData.symbol;
        print(listOfd);
        if (listOfd.contains(tokenData.symbol)) {
          await Get.defaultDialog(
            title: 'Message',
            middleText: 'Token Already Exist',
          );
          //Get.back();
          print('token already exist');
        }
        print(tokenData.symbol);
      } else {
        throw Exception('Failed to load Token');
      }
    } catch (e) {
      print(e.toString());
      print('hello');
      // outputData.value = ""; // set the data value to empty in case of an error
      Get.snackbar('Error', 'No Token Exist.',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          colorText: Colors.black);
      outputData.value = '';
    } finally {
      isLoading(false);
    }
  }

//   Future<String?> fetchsymbol(rpc, wallet, token) async {
//     try {
//       isLoading(true);
//       var dataTemp = await fetchData(rpc, wallet, token);
//       if (dataTemp != null) {
//         print('okokok');
//         outputData.value = dataTemp.symbol;
//         String aa = 'success';
//         print(dataTemp.symbol);
//         a = await dataTemp.symbol as RxString;
//         return aa;
//       } else {
//         print('cant find');
//         return dataTemp;
//       }
//     } catch (e) {
//       String a = e.toString();
//       print(e.toString());
//       return a;
// //      print(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
}

// Future fetchData(String rpc, String wallet, String token) async {
//   importToken tokenData;
//   final response = await http.get(Uri.parse(
//       'http://localhost:8081/imptoken?rpc=$rpc&wallet=$wallet&token=$token'));

//   if (response.statusCode == 200) {
//     tokenData = await importToken.fromJson(jsonDecode(response.body));
//     // return response;
//     //  print('!!!!!!!!!!!!!' + accountData.privateKey + 'asdadasdsad');
//   } else {
//     return throw Exception('Failed to load album');
//   }
//   return tokenData;
// }

