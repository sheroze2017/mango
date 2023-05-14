import 'package:http/http.dart' as http;

import 'dart:convert';

Future<double> getTokenPrice(String input) async {
  var response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price?ids=zillion-aakar-xo&vs_currencies=usd'));
  if (response.statusCode == 200) {
    final data = await jsonDecode(response.body);
    final usdPrice = await data['zillion-aakar-xo']['usd'];
    var zaxvalue =
        await double.parse(usdPrice.toString()) * double.parse(input);

    var response2 = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=BNBUSDT'));
    if (response2.statusCode == 200) {
      final jsonResponse = await json.decode(response2.body);
      final bnbUsdPrice = await double.parse(jsonResponse['price']);
      var zaxvalue2 = await zaxvalue / bnbUsdPrice;
      print(await 'hihihihih');
      print(await 'hihihihih');
      print(await zaxvalue2);
      return zaxvalue2;
    } else {
      throw Exception('Failed to fetch BNB/USD price');
    }
  } else {
    throw Exception('Failed to fetch token price');
  }
}
