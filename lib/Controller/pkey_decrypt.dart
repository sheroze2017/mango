import 'dart:convert';

import 'package:http/http.dart' as http;

import 'node.dart';

Future<String> getdata(pkey) async {
  var response = await http.get(
    Uri.parse('https://sbgwallet.io:9000/api/decrypt?input=' + pkey),
  );
  // print(response.body);
  var decodedResponse = await jsonDecode(response.body);
  String privateKey = await decodedResponse['privateKey']['privateKey'];
  //print(privateKey);
  return privateKey;
}
