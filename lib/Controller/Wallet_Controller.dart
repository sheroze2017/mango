import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../Model/Wallet_Model.dart';

class WalletController extends GetxController {
  final _storage = FlutterSecureStorage();

  //var wallets = <WalletModel>[].obs;
  var isDataLoadingCompleted = false.obs;
  var walletToDataMap = <String, Map<String, String>>{}.obs;

  var balance = <dynamic>["0", "0", "0"].obs;
  var token_address = <dynamic>[
    "0x9767c8E438Aa18f550208e6d1fDf5f43541cC2c8",
    "0x9A2478C4036548864d96a97Fbf93f6a3341fedac",
    "0xa03110800894b3CcF8723D991d80875561F96777"
  ].obs;
  var network_name = [
    "BNB Smart Chain",
    "Ethereum Mainnet",
    "SBG Specail Network Powered by Flashbots",
    "Avalanche",
    "Polygon"
  ].obs;
  var network_rpc = [
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
    "https://eth.llamarpc.com",
    "https://rpc.flashbots.net",
    "https://api.avax.network/ext/bc/C/rpc",
    "https://polygon-rpc.com"
  ];
  var wallet_address = <dynamic>["a", "b", "c"].obs;
  var symbol = <dynamic>["MMIT", "ZAX", "BGVT"].obs;
  var rpc = <dynamic>[
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d",
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d	"
  ].obs;
  @override
  void onInit() {
    super.onInit();
    // fetchData();
  }

  fetchData() async {
    // await _storage.write(key: 'balance', value: jsonEncode(balance));
    // await _storage.write(
    //     key: 'token_address', value: jsonEncode(token_address));
    // await _storage.write(
    //     key: 'wallet_address', value: jsonEncode(wallet_address));
    // await _storage.write(key: 'symbol', value: jsonEncode(symbol));
    // await _storage.write(key: 'rpc', value: jsonEncode(rpc));
    String? a = await _storage.read(key: 'balance');
    List<dynamic> listOfa = await jsonDecode(a!);
    balance.assignAll(listOfa);
    balance.refresh();

    //balance=await listOfa as RxList;
    // print(balance);
    // balance=b;
    String? b = await _storage.read(key: 'token_address');
    List<dynamic> listOfb = await jsonDecode(b!);
    //token_address = listOfb as RxList;
    token_address.assignAll(listOfb);
    token_address.refresh;
    // print(token_address);

    String? c = await _storage.read(key: 'wallet_address');
    List<dynamic> listOfc = await jsonDecode(c!);
    wallet_address.assignAll(listOfc);
    // wallet_address = listOfc as RxList;
    wallet_address.refresh();

    String? d = await _storage.read(key: 'symbol');
    List<dynamic> listOfd = await jsonDecode(d!);
    symbol.assignAll(listOfd);
    //symbol = listOfd as RxList;
    symbol.refresh();

    String? e = await _storage.read(key: 'rpc');
    List<dynamic> listOfe = await jsonDecode(e!);
    rpc.assignAll(listOfe);
    rpc.refresh();

    for (var i = 0; i < balance.length; i++) {
      var wallet = token_address[i];
      var symbolData = symbol[i];
      var rpcData = rpc[i];
      var balanceData = balance[i];

      walletToDataMap[symbolData] = {
        'token_address': wallet,
        'symbol': symbolData,
        'rpc': rpcData,
        'balance': balanceData,
      };
    }
    print(walletToDataMap);

    //rpc = listOfe as RxList;
    //  var a= await _storage.read(key: 'balance');
    //  var b=jsonDecode(a.toString());
    //  print(b[1]);
//     var walletjson = await rootBundle.loadString("lib/json/wallet.json");
//     print(walletjson);

//     var decodeData = jsonDecode(walletjson);
//     print(decodeData);
//   //  print (decodeData);
//     wallets.value = List.from(decodeData).map((e) => WalletModel.fromMap(e)).toList();

//     isDataLoadingCompleted.value = true;
// print(wallets[1].Imag);
//   void destory()
//   {
//     wallets.value= [];
//   }
  }
}

Future importToken(String rpc, String wallet, String token) async {
  WalletModel tokenData;
  final response = await http.get(
    Uri.parse(
        'https://sbgwallet.io:9000/api/imptoken?rpc=$rpc&wallet=$wallet&token=$token'),
  );

  if (response.statusCode == 200) {
    tokenData = await WalletModel.fromJson(jsonDecode(response.body));
    // return response;
    //  print('!!!!!!!!!!!!!' + accountData.privateKey + 'asdadasdsad');
  } else {
    throw Exception('Failed to load data');
  }

  return tokenData;
}
