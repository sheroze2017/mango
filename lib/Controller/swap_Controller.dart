import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sbgwallet/Model/convertRate_model.dart';
import 'package:sbgwallet/test2.dart';

import '../Secret_Key.dart';

class swapController extends GetxController {
  final _storage = FlutterSecureStorage();
  RxString selectedValuefromExc = "".obs;
  RxString selectedValuetoExc = "".obs;
  var isLoading = false.obs;
  var datafetch = false.obs;
  var isLoadingscreen = false.obs;
  var tokenCoin = <dynamic>["BNB"].obs;
  var rpccoin = <dynamic>[
    "https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d ",
    // 'https://rpc.flashbots.net',
  ].obs;
  var tokenAddress = <dynamic>[
    //  'https://eth.llamarpc.com',
    '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
    // 'https://rpc.flashbots.net',
    // 'https://api.avax.network/ext/bc/C/rpc',
    // 'https://polygon-rpc.com'
  ].obs;
  var uniqueList = <String>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await fetchToken();
  }

  fetchToken() async {
    String? a = await _storage.read(key: 'symbol');
    List<dynamic> listOfa = await jsonDecode(a!);
    tokenCoin.addAll(await listOfa);
    for (String element in tokenCoin) {
      if (!uniqueList.contains(element)) {
        uniqueList.add(element);
      }
    }
    print(uniqueList);
    String? b = await _storage.read(key: 'rpc');
    List<dynamic> listOfb = await jsonDecode(b!);
    rpccoin.addAll(await listOfb);
    print(rpccoin);

    String? c = await _storage.read(key: 'token_address');
    List<dynamic> listOfc = await jsonDecode(c!);
    tokenAddress.addAll(await listOfc);
    print(tokenAddress);
  }

  swapToken(String pkey, String amt, String outtoken, String intoken) async {
    isLoadingscreen(true);
    //sendCoin coinData;
    print(pkey);
    print(amt);
    print(intoken);
    print(outtoken);
    try {
      final response = await http.get(
        Uri.parse('https://sbgwallet.io:9000/api/decrypt?input=' + pkey),
      );

      if (response.statusCode == 200) {
        var a = Album.fromJson(jsonDecode(response.body));
        String pk = await a.privateKey.product_image;
        print(pk);
        //   Map data2 = {
        //   'uri': uri,
        //   'inToken': intoken,
        //   'outToken': '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
        //   'input': input
        // };
        Map data = {
          'privateKey': pk,
          'inputAmount': amt,
          'inToken': intoken,
          'outToken': outtoken
        };
        final String apiUrl = 'https://sbgwallet.io:9000/api/swap2token';

        try {
          var response5 = await http.post(Uri.parse(apiUrl),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: data);
          // final http.Response response = await http.post(Uri.parse(apiUrl),
          //     body: jsonEncode(data),
          //     headers: {'Content-Type': 'application/json'});

          if (response5.statusCode == 200) {
            //swap = await swapf3.fromJson(jsonDecode(response.body));
            //late SharedPreferences prefs;
            await Get.snackbar('Message', 'Swap Successfully Done',
                duration: Duration(seconds: 2),
                backgroundColor: Colors.white,
                colorText: Colors.black);
          } else if (response5.statusCode == 400 ||
              response5.statusCode == 401) {
            await Get.snackbar('Error', 'Can`t Swap Insufficient Funds',
                duration: Duration(seconds: 2),
                backgroundColor: Colors.white,
                colorText: Colors.black);
          }
        } catch (e) {
          print(e.toString());
          Get.snackbar('Error', 'Incorrect Input',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        } finally {
          isLoadingscreen.value = false;
          // datafetch.value=false;
        }
        return pk;
        //  return Album.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoadingscreen.value = false;
      datafetch.value = false;
    }

    // swapf3 swap;
  }

  nonNativeToNative(String pkey, String amt, String uri, String outtoken,
      String inToken) async {
    isLoadingscreen(true);
    try {
      final response = await http.get(
        Uri.parse('https://sbgwallet.io:9000/api/decrypt?input=' + pkey),
      );

      if (response.statusCode == 200) {
        var a = Album.fromJson(jsonDecode(response.body));
        String pk = await a.privateKey.product_image;
        Map data6 = {
          'privateKey': pk,
          'uri': uri,
          'outToken': outtoken,
          'inToken': inToken,
          'inputAmount': amt,
        };
        final String apiUrl = 'https://sbgwallet.io:9000/api/nonNativetoNative';
        try {
          var response6 = await http.post(Uri.parse(apiUrl),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: data6);

          if (response6.statusCode == 200) {
            //   swap = await swapf3.fromJson(jsonDecode(response.body));
            //   late SharedPreferences prefs;
            await Get.snackbar('Message', 'Swap Successfully Done',
                duration: Duration(seconds: 2),
                backgroundColor: Colors.white,
                colorText: Colors.black);
          } else if (response6.statusCode == 400 ||
              response6.statusCode == 401) {
            await Get.snackbar('Error', 'Can`t Swap, Insufficient Funds',
                duration: Duration(seconds: 2),
                backgroundColor: Colors.white,
                colorText: Colors.black);
          }
        } catch (e) {
          print(e.toString());
          Get.snackbar('Error', 'Incorrect Input',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.white,
              colorText: Colors.black);
        } finally {
          isLoadingscreen.value = false;
        }
        return pk;
        //  return Album.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoadingscreen.value = false;
      datafetch.value = false;
    }
  }

// import convertion rate
  late String test;
  RxString outputDataTo = RxString('');
  void clearOutputDataTo() async {
    outputDataTo.value = '';
  }

  multiple(double num) async {
    print('gfgfgfgfg');
    print(num);
    print(outputDataTo.value);
    //outputDataTo.value = num.toString();
    outputDataTo.value = await (double.parse(test) * num).toString();
    print((double.parse(test) * num));
  }

  fetchData(String uri, String intoken, String outtoken, String input) async {
    final String apiUrl =
        'https://sbgwallet.io:9000/api/swapf3ConversionAmount';

    convertRate Data;
    convertRate Data2;
    convertRate Data3;
    if (intoken != '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c' &&
        outtoken != '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c') {
      // print(intoken);
      // print(outtoken);
      print('okok');

      Map data2 = await {
        'uri': uri,
        'inToken': intoken,
        'outToken': '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
        'input': input
      };
      try {
        var a;
        if (intoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
          var zax = await getTokenPrice(input);
          a = await zax.toStringAsFixed(18);

          // a = await (double.parse(Data2.estimatedOutputAmount) * 1000000000)
          //     .toStringAsFixed(18);
          // print(Data2.estimatedOutputAmount.toString());
          print(a);
        } else {
          var response1 = await http.post(Uri.parse(apiUrl),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: data2);
          if (response1.statusCode == 200) {
            Data2 = await convertRate.fromJson(jsonDecode(response1.body));
            //var a;
            // if (intoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            //   var zax = await getTokenPrice(input);
            //   a = await zax.toStringAsFixed(18);

            //   // a = await (double.parse(Data2.estimatedOutputAmount) * 1000000000)
            //   //     .toStringAsFixed(18);
            //   // print(Data2.estimatedOutputAmount.toString());
            //   print(a);
            // } else
            // {
            a = await double.parse(Data2.estimatedOutputAmount)
                .toStringAsFixed(18);
            //    print(a);
          }
          // .toStringAsFixed(2);
          // var intoken = '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';
          print(await a);
          print(intoken);
          print(outtoken);
        }
        Map data3 = {
          'uri': uri,
          'inToken': '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
          'outToken': outtoken,
          'input': a
        };
        //try {
        var response = await http.post(Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data3);
        if (response.statusCode == 200) {
          //  print('data3333');
          Data3 = await convertRate.fromJson(jsonDecode(response.body));
          print(Data3.estimatedOutputAmount.toString());
          var b;
          if (outtoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            b = await double.parse(Data3.estimatedOutputAmount) * 1000000000;
            outputDataTo.value = await b.toString();
            print(outputDataTo.value);
            test = await outputDataTo.value;
          } else {
            b = await Data3.estimatedOutputAmount;
            outputDataTo.value = await b.toString();
            test = await outputDataTo.value;
          }
        } else {
          throw Exception('Failed to load Token');
        }
        // } catch (e) {
        //  print(e.toString());
        //  print('hello');

        // outputDataTo.value = '';

        // outputDataTo.value = ""; // set the data value to empty in case of an error
        //Get.snackbar('Error', 'No Token Exist.');
        // } finally {
        //isLoading(false);
        // }
        // } else {
        //   throw Exception('Failed to load Token');
        // }
      } catch (e) {
        print(e.toString());
        print('hello');

        outputDataTo.value = '';

        // outputDataTo.value = ""; // set the data value to empty in case of an error
        //Get.snackbar('Error', 'No Token Exist.');
      } finally {
        //isLoading(false);
      }
    } else {
      Map data = {
        'uri': uri,
        'inToken': intoken,
        'outToken': outtoken,
        'input': input
      };

      // isLoading(true);
      try {
        var response = await http.post(Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data);
        if (response.statusCode == 200) {
          Data = await convertRate.fromJson(jsonDecode(response.body));
          print(Data.estimatedOutputAmount.toString());
          if (outtoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            var a = await double.parse(Data.estimatedOutputAmount) * 1000000000;
            outputDataTo.value = await a.toString();
            test = outputDataTo.value;
          } else if (intoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            print('hhhhhhh');
            print(input);
            print(input.runtimeType);
            var zax = await getTokenPrice(input);
            // var a = await double.parse(Data.estimatedOutputAmount) * 1000000000;
            outputDataTo.value = await zax.toString();
            test = outputDataTo.value;
          } else {
            print('ok');
            var a = await Data.estimatedOutputAmount;
            outputDataTo.value = await a.toString();
            test = outputDataTo.value;
          }
        } else {
          throw Exception('Failed to load Token');
        }
      } catch (e) {
        print(e.toString());
        print('hello');

        outputDataTo.value = '';

        // outputDataTo.value = ""; // set the data value to empty in case of an error
        //Get.snackbar('Error', 'No Token Exist.');
      } finally {
        //isLoading(false);
      }
    }
  }

  late String test2;

  RxString outputDataFrom = RxString('');
  void clearOutputDataFrom() async {
    outputDataFrom.value = '';
  }

  multiplefrom(double num) async {
    //outputDataTo.value = num.toString();
    print('hello');
    outputDataFrom.value = (double.parse(test2) * num).toString();
    print((double.parse(test2) * num));
  }

  fetchDatafrom(
      String uri, String intoken, String outtoken, String check) async {
    final String apiUrl =
        'https://sbgwallet.io:9000/api/swapf3ConversionAmount';
    String input = "1";
    convertRate Data;
    convertRate Data2;
    convertRate Data3;
    if (intoken != '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c' &&
        outtoken != '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c') {
      print('oko');
      print(intoken);
      print(outtoken);
      Map data2 = {
        'uri': uri,
        'inToken': intoken,
        'outToken': '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
        'input': input
      };
      try {
        var a;
        if (intoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
          var zax = await getTokenPrice(input);
          // var a = await double.parse(Data.estimatedOutputAmount) * 1000000000;
          // outputDataTo.value = await zax.toString();
          //  print('giohg');
          // a = await (double.parse(Data2.estimatedOutputAmount) * 1000000000)
          //     .toStringAsFixed(18);
          a = await zax.toStringAsFixed(18);
          print(a);
        } else {
          var response1 = await http.post(Uri.parse(apiUrl),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: data2);
          if (response1.statusCode == 200) {
            print('worldworld');
            Data2 = await convertRate.fromJson(jsonDecode(response1.body));
            print('ok');
            print(Data2.estimatedOutputAmount.toString());
            print('ok');

            a = await double.parse(Data2.estimatedOutputAmount)
                .toStringAsFixed(18);
            print(a);
          }
        }
        // .toStringAsFixed(2);
        // var intoken = '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';
        Map data3 = {
          'uri': uri,
          'inToken': '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
          'outToken': outtoken,
          'input': a
        };
        //try {
        var response = await http.post(Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data3);
        if (response.statusCode == 200) {
          print('chaltha nhi');
          Data3 = await convertRate.fromJson(jsonDecode(response.body));
          print(Data3.estimatedOutputAmount.toString());
          var b;
          if (outtoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            b = await (double.parse(Data3.estimatedOutputAmount) * 1000000000)
                .toString();
            outputDataFrom.value = await b.toString();
            test2 = outputDataFrom.value;
          } else {
            b = await Data3.estimatedOutputAmount.toString();
            outputDataFrom.value = await b.toString();
            test2 = outputDataFrom.value;
          }
        } else {
          throw Exception('Failed to load Token');
        }
      } catch (e) {
        print(e.toString());
        print('hello');

        outputDataFrom.value = '';

        // outputDataTo.value = ""; // set the data value to empty in case of an error
        //Get.snackbar('Error', 'No Token Exist.');
      } finally {
        // isLoading(false);
      }
    } else {
      print(intoken);
      print(outtoken);
      Map data = {
        'uri': uri,
        'inToken': intoken,
        'outToken': outtoken,
        'input': input
      };
      // isLoading(true);
      try {
        var response = await http.post(Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data);
        if (response.statusCode == 200) {
          Data = await convertRate.fromJson(jsonDecode(response.body));
          print('ok');
          print(Data.estimatedOutputAmount.toString());
          print('ok');
          if (outtoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            print('hihi');
            var a = (double.parse(Data.estimatedOutputAmount) * 1000000000)
                .toString();
            outputDataFrom.value = await a.toString();
            test2 = outputDataFrom.value;
          } else if (intoken == "0x9A2478C4036548864d96a97Fbf93f6a3341fedac") {
            var zax = await getTokenPrice(input);
            // var a = await double.parse(Data.estimatedOutputAmount) * 1000000000;
            outputDataFrom.value = await zax.toString();
            // var a = (double.parse(Data.estimatedOutputAmount) * 1000000000)
            //     .toString();
            // outputDataFrom.value = await a.toString();
            test2 = outputDataFrom.value;
          } else {
            var a = Data.estimatedOutputAmount.toString();
            outputDataFrom.value =
                await (double.parse(a) * double.parse(check)).toString();
            test2 = outputDataFrom.value;
          }
          //.toStringAsFixed(2);
        } else {
          throw Exception('Failed to load Token');
        }
      } catch (e) {
        print(e.toString());
        print('hello');
        outputDataFrom.value = '';

        // outputDataTo.value = ""; // set the data value to empty in case of an error
        //Get.snackbar('Error', 'No Token Exist.');
      } finally {
        //isLoading(false);
      }
    }
  }
}
