import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/multiwallet__controller.dart';
import 'package:sbgwallet/Controller/realBalance_Controller.dart';
import 'package:sbgwallet/theme_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/Wallet_Controller.dart';
import 'Controller/importToken_Controller.dart';
import 'Start.dart';
import 'WalletPage_assets.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final _storage = FlutterSecureStorage();

  TokenController TController = Get.put(TokenController());
  // swapController SController = Get.put(swapController());
  WalletController WController = Get.put(WalletController());
  MyController MController = Get.put(MyController());
  multiwallet controller = Get.put(multiwallet());
  //getTokenPrice();

  await GetStorage.init();
  Timer.periodic(Duration(seconds: 5), (timer) async {
    controller.loaddata();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rpcUrl = await prefs.getString('rpcUrl') ?? '';
    String walletAddress = await _storage.read(key: 'address') as String;
    String symbol = await prefs.getString('Symbol') ?? '';
// final String walletAddress = '0x624F89f31170df4f6dD147db230798386A0777eC';
    //final String rpcUrl = 'https://bsc.publicnode.com';

    final http.Response response = await http.post(Uri.parse(rpcUrl),
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
    await prefs.setDouble('balance', balanceInBnb);
    double balanceInB = balanceInBnb;
    //print(balanceInB.runtimeType);
    await MController.getNumber();
    //  await SController.fetchToken();
    print('The balance of the wallet $walletAddress is $balanceInB $symbol');

    String? a = await _storage.read(key: 'rpc');
    String? b = await _storage.read(key: 'wallet_address');
    String? c = await _storage.read(key: 'token_address');
    List listOfa = await jsonDecode(a!);
    //  List<dynamic> listOfb = await jsonDecode(b!);
    List listOfc = await jsonDecode(c!);
    List balance = [];

    try {
      for (int i = 0; i < listOfa.length; i++) {
        // print(listOfa[i] + listOfb[i] + listOfc[i]);
        // print(listOfa[i]+'\n');
        final tokenData = await fetchData(listOfa[i].toString(),
            walletAddress.toString(), listOfc[i].toString());
        if (tokenData != null) {
          balance.add(await tokenData.balance);
          // // Do something with tokenData
          // print(tokenData);
        }
      }

      print(await balance);
      String? a = await _storage.read(key: 'balance');
      List<dynamic> listofbal = await jsonDecode(a!);
      listofbal.replaceRange(0, listofbal.length, balance);
      await _storage.write(key: 'balance', value: jsonEncode(listofbal));
      await WController.fetchData();
    } catch (e) {
      print('Error fetching token data: $e');
    }
  });

  // await dotenv.load(
  //   fileName: '.env',
  // );
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // dotenv.load();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool _icon = false;

IconData _Lighticon = Icons.wb_sunny;
IconData _Darkicon = Icons.nights_stay;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mango Wallet',
          //  themeMode:ThemeMode.system,
          //  theme: ThemeClass.lightTheme ,
// darkTheme: ThemeClass.darkTheme,
// themeMode: ThemeMode.system,
          // darkTheme:ThemeClass.darkTheme,
          theme: _icon ? ThemeClass.lightTheme : ThemeClass.darkTheme,
          darkTheme: ThemeClass.lightTheme,
          //theme: _icon ? _DarkTheme: _LightTheme,

          initialRoute: '/',
          routes: {
            '/': (_) => Start(),
            '/home': (_) => WalletPage_asset(),
          });
      //   home: MyApp());
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
