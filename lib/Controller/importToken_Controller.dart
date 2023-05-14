import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sbgwallet/Model/importtoken_model.dart';

class TokenController extends GetxController {
  var data = [].obs;
  final _storage = FlutterSecureStorage();
  // RxList<importToken> tokenlist = <importToken>[].obs;

  var isLoading = true.obs;
  Future<String?> fetch(rpc, wallet, token) async {
    try {
      isLoading(true);
      var dataTemp = await fetchData(rpc, wallet, token);
      if (dataTemp != null) {
        String aa = 'success';
        //     tokenlist.add(await dataTemp);
        //   await _storage.write(key: 'tokenList', value: jsonEncode(tokenlist));
        String? a = await _storage.read(key: 'balance');
        List<dynamic> listOfa = await jsonDecode(a!);
        listOfa.add(await dataTemp.balance);

        await _storage.write(key: 'balance', value: jsonEncode(listOfa));
        print(listOfa);

        String? b = await _storage.read(key: 'token_address');
        List<dynamic> listOfb = await jsonDecode(b!);
        listOfb.add(await dataTemp.tokenAddress);
        await _storage.write(key: 'token_address', value: jsonEncode(listOfb));
        print(listOfb);

        String? c = await _storage.read(key: 'wallet_address');
        List<dynamic> listOfc = await jsonDecode(c!);
        listOfc.add(await dataTemp.walletAddress);
        await _storage.write(key: 'wallet_address', value: jsonEncode(listOfc));

        String? d = await _storage.read(key: 'symbol');
        List<dynamic> listOfd = await jsonDecode(d!);
        listOfd.add(await dataTemp.symbol);
        await _storage.write(key: 'symbol', value: jsonEncode(listOfd));

        String? e = await _storage.read(key: 'rpc');
        List<dynamic> listOfe = await jsonDecode(e!);
        listOfe.add(await dataTemp.rpc);
        await _storage.write(key: 'rpc', value: jsonEncode(listOfe));
        print(listOfe);
        return aa;
      } else {
        String aa = "unsuccess";
        return aa;
      }
    } finally {
      isLoading(false);
    }
  }
}

Future fetchData(String rpc, String wallet, String token) async {
  importToken tokenData;
  final response = await http.get(
    Uri.parse(
        'https://sbgwallet.io:9000/api/imptoken?rpc=$rpc&wallet=$wallet&token=$token'),
  );

  if (response.statusCode == 200) {
    tokenData = await importToken.fromJson(jsonDecode(response.body));
    // return response;
    //  print('!!!!!!!!!!!!!' + accountData.privateKey + 'asdadasdsad');
  } else {
    throw Exception('Failed to load album');
  }
  return tokenData;
}
