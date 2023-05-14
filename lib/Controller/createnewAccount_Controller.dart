import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/accountimport_model.dart';

class newAccountImport extends GetxController {
  var data = [].obs;
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
  var trasactionhash = <dynamic>[];
  var trasactioncoinhash = <dynamic>[];
  var chainbalance = <dynamic>[0.0, 0.0, 0.0, 0.0, 0.0];
  final _storage = FlutterSecureStorage();
  var datakey = [].obs;
  var dataadd = [].obs;

  var isLoading = false.obs;
  void fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      var dataTemp = await fetchData();
      if (dataTemp != null) {
        // _privateKey = dataTemp.privateKey;
        // _address = dataTemp.address;
        // privateKey = dataTemp.privateKey;
        // address = dataTemp.address;
        data.insert(await 0, dataTemp.privateKey);
        data.insert(await 1, dataTemp.address);
        await prefs.setString('pkey', dataTemp.privateKey);

        // data.add(dataTemp.privateKey);
        // data.add(dataTemp.address);

        Future.delayed(const Duration(seconds: 0), () async {
          print(dataTemp.privateKey);
          print(dataTemp.address);
          print(data[0]);
          print(data[1]);

          await _storage.delete(key: 'balance');
          await _storage.delete(key: 'transactionHash');
          await _storage.delete(key: 'transactioncoinhash');
          await _storage.delete(key: 'token_address');
          await _storage.delete(key: 'wallet_address');
          await _storage.delete(key: 'symbol');
          await _storage.delete(key: 'rpc');
          await _storage.delete(key: 'chainBalance');

          await _storage.write(key: 'balance', value: jsonEncode(balance));
          await _storage.write(
              key: 'transactionHash', value: jsonEncode(trasactionhash));
          await _storage.write(
              key: 'transactioncoinhash',
              value: jsonEncode(trasactioncoinhash));
          await _storage.write(
              key: 'token_address', value: jsonEncode(token_address));
          await _storage.write(
              key: 'wallet_address', value: jsonEncode(wallet_address));
          await _storage.write(key: 'symbol', value: jsonEncode(symbol));
          await _storage.write(key: 'rpc', value: jsonEncode(rpc));
          await _storage.write(
              key: 'chainBalance', value: jsonEncode(chainbalance));

          await _storage.write(key: 'listOfdata', value: jsonEncode(data));
          String? stringOfItems = await _storage.read(key: 'listOfdata');
          List<dynamic> listOfItems = await jsonDecode(stringOfItems!);
          await _storage.delete(key: 'privatekey');
          await _storage.delete(key: 'encryptpk');
          //await _storage.delete(key: 'balance');
          //await _storage.delete(key: 'listOfdata');
          await _storage.delete(key: 'address');
          await _storage.write(key: 'privatekey', value: data[0].toString());
          await _storage.write(key: 'address', value: data[1].toString());
          var s = await _storage.read(key: 'address');

          String? datak = await _storage.read(key: 'datakey');
          List<dynamic> listkey = await jsonDecode(datak!);
          listkey.insert(await 0, data[0].toString());
          await _storage.write(key: 'datakey', value: jsonEncode(listkey));

          String? dataa = await _storage.read(key: 'dataadd');
          List<dynamic> listadd = await jsonDecode(dataa!);
          listadd.insert(await 0, data[1].toString());
          _storage.write(key: 'dataadd', value: jsonEncode(listadd));
          String phrase = await '';

          Get.offAllNamed('/home',
              arguments: [phrase, data[1].toString(), data[0].toString()]);

          print(s.toString());
          print(data.length);
        });
        print('successfull');
        // print(dataTemp.address.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}

Future fetchData() async {
  accountPK newaccountData;
  final response = await http.get(
    Uri.parse('https://sbgwallet.io:9000/api/createnew1'),
  );

  if (response.statusCode == 200) {
    newaccountData = await accountPK.fromJson(jsonDecode(response.body));
    // return response;
    //  print('!!!!!!!!!!!!!' + accountData.privateKey + 'asdadasdsad');
  } else {
    throw Exception('Failed to load album');
  }
  return newaccountData;
}
