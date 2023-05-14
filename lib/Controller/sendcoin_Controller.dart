import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/sendCoin_model.dart';

class sendC extends GetxController {
  final _storage = FlutterSecureStorage();

  //final selected = 'Polygon'.obs;
  // void setSelected(int i) {
  // selected.value = items[i];
  var trasactionCoinhash = [].obs;
  List<String> items = [
    'BNB Smart Chain',
    'Ethereum Mainnet',
    'SBG Specail Network Powered by Flashbots',
    'Avalanche',
    'Polygon'
  ];

  List<dynamic> balance = [0.0, 0.0, 1.1, 2.2, 4.0];
  var isLoading = false.obs;

//   Future<String?> fetch(key, from, to, val, rpc) async {
//     try {
//       isLoading(true);
//       var dataTemp = await sendc(key, from, to, val, rpc);
//       if (dataTemp != null) {
//         String? a = await _storage.read(key: 'transactioncoinhash');
//         List<dynamic> listOfb = await jsonDecode(a!);
//         late SharedPreferences prefs;
//         prefs = await SharedPreferences.getInstance();

//         if (dataTemp.hash == 1) {
//           await Get.snackbar('Transaction Error', 'Insufficient funds');
//           Get.back();
//         } else {
//           await Get.snackbar('Successfull', 'Transation done');
//           listOfb.add(await dataTemp.hash);
//           Get.back();
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// Future sendc(String key, String from, String to, String val, String rpc) async {
//   sendCoin sendcoin;
//   final response = await http.get(Uri.parse(
//       'http://localhost:8081/transfer?key=$key&from=$from&to=$to&val=$val&rpc=$rpc'));

//   if (response.statusCode == 200) {
//     sendcoin = await sendCoin.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to data');
//   }
//   return sendcoin;
// }
//  final _storage = FlutterSecureStorage();
//   var isLoading = true.obs;
//   RxString a = 'Symbol Name'.obs;
//   RxString outputData = RxString('Symbol Name');

//   void clearOutputData() {
//     outputData.value = '';
//   }
//
  sendc(String key, String from, String to, String val, String rpc) async {
    sendCoin coinData;

    try {
      print(key);
      print(from);
      print(to);
      print(val);
      print(rpc);
      var response = await http.get(
        Uri.parse(
            'https://sbgwallet.io:9000/api/transfer?key=$key&from=$from&to=$to&val=$val&rpc=$rpc'),
      );
      if (response.statusCode == 200) {
        coinData = await sendCoin.fromJson(jsonDecode(response.body));
        if (coinData.hash == 1) {
          await Get.snackbar('Transaction Error', 'Insufficient Funds',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        } else {
          String? a = await _storage.read(key: 'transactioncoinhash');
          List<dynamic> listOfb = await jsonDecode(a!);
          late SharedPreferences prefs;
          listOfb.add(await coinData.hash);
          await _storage.write(
              key: 'transactioncoinhash', value: jsonEncode(listOfb));
          await Get.snackbar('Message', 'Transfer Successfully Done',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Incorrect Input',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.white,
            colorText: Colors.black);
        throw Exception('Failed to load Token');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Incorrect Input',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }
}
