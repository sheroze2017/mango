import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class networkcontroller extends GetxController {
  var network_name = [
    "Ethereum Mainnet",
    "BNB Smart Chain",
    "SBG Specail Network Powered by Flashbots",
    "Avalanche",
    "Polygon"
  ];
  var network_rpc = [
    "https://eth.llamarpc.com",
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
    "SBG Specail Network Powered by Flashbots",
    "https://rpc.flashbots.net",
    "https://api.avax.network/ext/bc/C/rpc"
  ];
  var network_balance = [].obs;

  Future<void> getTokenPrice(String input) async {
    final _storage = FlutterSecureStorage();

    String walletAddress = await _storage.read(key: 'address') as String;

    for (int i = 0; i < network_rpc.length; i++) {
      final http.Response response = await http.post(Uri.parse(network_rpc[i]),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'jsonrpc': '2.0',
            'method': 'eth_getBalance',
            'params': ['$walletAddress', 'latest'],
            'id': 1,
          }));

      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      BigInt balanceInWei = await jsonResponse['result'] != null
          ? BigInt.parse(jsonResponse['result'].substring(2), radix: 16)
          : BigInt.zero;
      //print(balanceInWei.runtimeType);
      double balanceInBnb = await balanceInWei / BigInt.from(10).pow(18);
      network_balance[i] = balanceInBnb.toString();
      // await prefs.setDouble('balance', balanceInBnb);
      // double balanceInB = balanceInBnb;
      // //print(balanceInB.runtimeType);
      // await MController.getNumber();
      // //  await SController.fetchToken();
      // print('The balance of the wallet $walletAddress is $balanceInB $symbol');
    }
  }
}
