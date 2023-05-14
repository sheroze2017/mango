import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sbgwallet/Model/importAccount_model.dart';
import 'package:http/http.dart' as http;
import 'package:sbgwallet/Secret_Key.dart';
import 'package:sbgwallet/WalletPage_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'node.dart';

class recoverAccount extends GetxController {
  var data = [].obs;
  var datakey = [].obs;
  var dataadd = [].obs;
  final _storage = FlutterSecureStorage();
  var isLoading = true.obs;
  void fetch(phrase, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      await _storage.deleteAll();
      var _recoverdata = await recoverData(phrase);
      if (_recoverdata == null) {
        Get.snackbar('Error', 'No Account Exist',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.white,
            colorText: Colors.black);
      } else if (_recoverdata != null) {
        // _privateKey = dataTemp.privateKey;
        // _address = dataTemp.address;
        // privateKey = dataTemp.privateKey;
        // address = dataTemp.address;
        data.insert(0, _recoverdata.privateKey);
        data.insert(1, _recoverdata.address);
        data.insert(2, _recoverdata.encryptpk);
        data.insert(3, _recoverdata.balance);

        // data.add(dataTemp.privateKey);
        // data.add(dataTemp.address);

        await saveMyAddress(_recoverdata.address);
        // print(dataTemp.privateKey);
        // print(dataTemp.address);
        print(data[0]);
        print(data[1]);
        await prefs.setString('pkey', _recoverdata.privateKey);

        await _storage.write(key: 'listOfdata', value: jsonEncode(data));
        String? stringOfItems = await _storage.read(key: 'listOfdata');
        List<dynamic> listOfItems = await jsonDecode(stringOfItems!);

        // await _storage.delete(key: 'privatekey');
        // await _storage.delete(key: 'address');
        await _storage.write(key: 'privatekey', value: data[0].toString());
        await _storage.write(key: 'address', value: data[1].toString());
        await _storage.write(key: 'encryptpk', value: data[2].toString());
        await _storage.write(key: 'balance', value: data[3].toString());
        await _storage.write(key: 'password', value: password.toString());

        datakey.add(await data[0].toString());
        dataadd.add(await data[1].toString());

        await _storage.write(key: 'datakey', value: jsonEncode(datakey));
        await _storage.write(key: 'dataadd', value: jsonEncode(dataadd));

        var balance = <dynamic>["0", "0", "0"];
        var token_address = <dynamic>[
          "0x9767c8E438Aa18f550208e6d1fDf5f43541cC2c8",
          "0x9A2478C4036548864d96a97Fbf93f6a3341fedac",
          "0xa03110800894b3CcF8723D991d80875561F96777"
        ];
        var wallet_address = <dynamic>["a", "b", "c"];
        var symbol = <dynamic>["MMIT", "ZAX", "BGVT"];
        var rpc = <dynamic>[
          "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
          "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
          "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
        ];
        var trasactionhash = [];
        var trasactioncoinhash = [];
        var chainbalance = <dynamic>[0.0, 0.0, 0.0, 0.0, 0.0];

        await _storage.write(key: 'balance', value: jsonEncode(balance));
        await _storage.write(
            key: 'transactionHash', value: jsonEncode(trasactionhash));
        await _storage.write(
            key: 'transactioncoinhash', value: jsonEncode(trasactioncoinhash));
        await _storage.write(
            key: 'token_address', value: jsonEncode(token_address));
        await _storage.write(
            key: 'wallet_address', value: jsonEncode(wallet_address));
        await _storage.write(key: 'symbol', value: jsonEncode(symbol));
        await _storage.write(key: 'rpc', value: jsonEncode(rpc));
        await _storage.write(
            key: 'chainBalance', value: jsonEncode(chainbalance));
        var address = await _storage.read(key: 'address');
        await _storage.write(key: 'accountexist', value: '1');

        await Get.to(WalletPage_asset(),
            arguments: [phrase, data[1].toString(), data[0].toString()]);
        print(data.length);

        print('successfull');
        // print(dataTemp.address.toString());
      }
    } finally {
      isLoading(false);
    }
  }
}

Future recoverData(String phrase) async {
  importwallet accountData;
  final response = await http.get(
    Uri.parse('https://sbgwallet.io:9000/api/machimp?input=$phrase'),
  );

  if (response.statusCode == 200) {
    print('sssss');
    accountData = await importwallet.fromJson(jsonDecode(response.body));
    print(accountData.privateKey);
    print(accountData.balance);
    print(accountData.encryptpk);
    print(accountData.address);
    //return response;
    //  print('!!!!!!!!!!!!!' + accountData.privateKey + 'asdadasdsad');
  } else {
    throw Exception('Failed to load album');
  }
  return accountData;
}

Future<void> saveMyAddress(String address) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('address', address);
}
