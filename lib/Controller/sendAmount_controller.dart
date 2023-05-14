import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sbgwallet/Model/sendAmount_model.dart';
import 'package:http/http.dart' as http;

class sendA extends GetxController {
  final _storage = FlutterSecureStorage();

  //final selected = 'Polygon'.obs;
  // void setSelected(int i) {
  // selected.value = items[i];
  var trasactionhash = [].obs;
  List<String> items = [
    'Ethereum Mainnet',
    'BNB Smart Chain',
    'SBG Specail Network Powered by Flashbots',
    'Avalanche',
    'Polygon'
  ];

  List<dynamic> balance = [0.0, 0.0, 1.1, 2.2, 4.0];
  var isLoading = false.obs;

  // Future<String?> fetch(to, privateKey, amount, tadrs, rpc) async {
  //   try {
  //     isLoading(true);
  //     var dataTemp = await send(to, privateKey, amount, tadrs, rpc);
  //     if (dataTemp != null) {
  //       String? a = await _storage.read(key: 'transactionHash');
  //       List<dynamic> listOfa = await jsonDecode(a!);
  //       late SharedPreferences prefs;
  //       prefs = await SharedPreferences.getInstance();

  //       if (dataTemp.response == 1) {
  //         await Get.snackbar('Transaction Error', 'Insufficient funds');
  //         Get.back();
  //       } else {
  //         await Get.snackbar('Successfull', 'Transation done');
  //         listOfa.add(await dataTemp.response);

  //         Get.back();
  //       }
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

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
  void sendtoken(String to, String privateKey, String amount, String tadrs,
      String rpc) async {
    sendamount tokenData;
    print(privateKey.toString());
    try {
      print('hi');
      print(privateKey);
      print(to);
      print(amount);
      print(tadrs);
      print(rpc);
      print('hi');
      var response = await http.get(
        Uri.parse(
            'https://sbgwallet.io:9000/api/transfertcn?to=$to&privateKey=$privateKey&amount=$amount&tadrs=$tadrs&rpc=$rpc'),
      );
      if (response.statusCode == 200) {
        tokenData = await sendamount.fromJson(jsonDecode(response.body));
        print(tokenData.response);
        if (tokenData.response == 1) {
          await Get.snackbar('Transaction Error', 'Check Address or Balance',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        } else {
          String? a = await _storage.read(key: 'transactionHash');
          List<dynamic> listOfb = await jsonDecode(a!);
          listOfb.add(await tokenData.response);
          await _storage.write(
              key: 'transactionHash', value: jsonEncode(listOfb));
          await Get.snackbar('Message', 'Transfer Successfully Done',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        }
      } else {
        throw Exception('Failed to load');
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


// Future send(String to, String privateKey, String amount, String tadrs,
//     String rpc) async {
//   sendamount sendtcn;
//   final response = await http.get(Uri.parse(
//       'http://localhost:8081/transfertcn?to=$to&privateKey=$privateKey&amount=$amount&tadrs=$tadrs&rpc=$rpc'));

//   if (response.statusCode == 200) {
//     sendtcn = await sendamount.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to data');
//   }
//   return sendtcn;
// }
