import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Richtextfile.dart';

import 'package:sbgwallet/Components/Textfile.dart';
import 'package:sbgwallet/Controller/Wallet_Controller.dart';
import 'package:sbgwallet/Dialog/Dialog_DepositETH.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Components/Tabbar_file.dart';
import 'Controller/realBalance_Controller.dart';
import 'Controller/rpc_Controller.dart';
import 'Dialog/Dialog_Import_token.dart';
import 'Dialog/Dialog_SendCoin.dart';

import 'Dialog/Dialog_myaccount.dart';
import 'Dialog/Dialog_swap.dart';
import 'Switch_button.dart';

class WalletPage_asset extends StatefulWidget {
  // final String phrase;
  // final String address;
  // final String pkey;

  // const WalletPage_asset(
  //     {super.key,
  //     required this.phrase,
  //     required this.address,
  //     required this.pkey});
  @override
  State<WalletPage_asset> createState() => _WalletPage_assetState();
}

class _WalletPage_assetState extends State<WalletPage_asset> {
  late SharedPreferences prefs;
  WalletController WController = Get.put(WalletController());
  MyController MController = Get.put(MyController());
  MyController123 molo = Get.put(MyController123());
  // late AnimationController _animationController;
  // late Animation<Color?> _colorAnimation;
  final _storage = FlutterSecureStorage();
  String? _address;
  String? _pkey;
  @override
  void initState() {
    _loadCredentials();
    onItemSelected('BNB Smart Chain');
    molo.onInit();
    super.initState();
    setState(() {
      onItemSelected('BNB Smart Chain');
      molo.onInit();
    });
    WController.fetchData();
    initPrefs();
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 2))
    //       ..repeat(reverse: true);

    // _colorAnimation = ColorTween(
    //         begin: Color.fromARGB(255, 110, 18, 153).withOpacity(0.5),
    //         end: Color.fromARGB(255, 150, 30, 206).withOpacity(0.5))
    //     .animate(_animationController);
  }

  Future<void> _loadCredentials() async {
    final add = await _storage.read(key: 'address');
    final pkey = await _storage.read(key: 'privatekey');
    setState(() {
      _address = add;
      _pkey = pkey;
    });
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  List<String>? items = [
    // 'Select Network',

    'BNB Smart Chain',
    'Ethereum Mainnet',
    'SBG Specail Network Powered by Flashbots',
    'Avalanche',
    'Polygon'
  ];
  String? selectedValue;

  _WalletPage_assetState() {
    selectedValue = 'BNB Smart Chain';
    saveMyname('BNB Smart Chain');
    saveMyChainId('56');
    saveMyRpc(
        'https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d');
    saveMySymbol('BNB');
    // set the first item as selected by default
    // selectedBalance;
    // set the balance of the first item as selected balance
    //saveMyBalance(0.0);
    // saveMyname('BNB Smart Chain');
    // saveMyChainId('56');
    // saveMyRpc(
    //     'https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d');
    // saveMySymbol('BNB');
    // saveMyname('Network');
    // saveMyChainId('Network');
    // saveMyRpc('Network');
    // saveMySymbol('Balance');
  }

  void onItemSelected(String? newValue) {
    setState(() {
      selectedValue = newValue!;

      if (newValue == 'Ethereum Mainnet') {
        // saveMyBalance(0.0);
        saveMyname('Ethereum MainNet');
        saveMyChainId('1');
        saveMyRpc('https://eth.llamarpc.com');
        saveMySymbol('ETH');
      } else if (newValue == 'BNB Smart Chain') {
        // saveMyBalance(0.0);
        saveMyname('BNB Smart Chain');
        saveMyChainId('56');
        saveMyRpc(
            'https://bsc-mainnet.gateway.pokt.network/v1/lb/6136201a7bad1500343e248d');
        saveMySymbol('BNB');
      }
      // else if (newValue == 'BNB TestNet') {
      //   // saveMyBalance(0.0);
      //   saveMyname('BNB test');
      //   saveMyChainId('97');
      //   saveMyRpc('https://endpoints.omniatech.io/v1/bsc/testnet/public');
      //   saveMySymbol('BNB');
      // }
      else if (newValue == 'SBG Specail Network Powered by Flashbots') {
        // saveMyBalance(0.0);
        saveMyname('SBG Specail Network Powered by Flashbots');
        saveMyChainId('1');
        saveMyRpc('https://rpc.flashbots.net');
        saveMySymbol('ETH');
      } else if (newValue == 'Avalanche') {
        // saveMyBalance(0.0);
        saveMyname('Avalanche');
        saveMyChainId('43114');
        saveMyRpc('https://api.avax.network/ext/bc/C/rpc');
        saveMySymbol('AVAX');
      } else if (newValue == 'Polygon') {
        // saveMyBalance(0.0);
        saveMyname('Polygon');
        saveMyChainId('137');
        saveMyRpc('https://polygon-rpc.com');
        saveMySymbol('MATIC');
      }
    });
  }

//  const WalletPage_asset({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime? _lastPressedAt;
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (_lastPressedAt == null ||
          now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
        _lastPressedAt = now;
        Get.snackbar('Message', 'Tap again to exit',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.white,
            colorText: Colors.black);
        return Future.value(false);
      }
      SystemNavigator.pop();

      return Future.value(true);
    }

    //   _check(context);
    WalletController WController = Get.put(WalletController());

    final List? arguments = Get.arguments;
    //final String phrase = arguments[0] ;
    final String address = (arguments?[1] ?? '') as String;
    final String private_key = (arguments?[2] ?? ' ') as String;

    var padding = MediaQuery.of(context).size.width;

    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: GestureDetector(
        onTap: () =>
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isLightMode
                      ? <Color>[
                          Colors.white,
                          Colors.white,
                        ]
                      : <Color>[
                          Colors.black,
                          // Color.fromARGB(255, 87, 16, 121).withOpacity(0.5),
                          Colors.black
                        ]),
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    //   top: padding / 10,
                    // left: padding / 20,
                    // right: padding / 20,
                    bottom: padding / 13),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "Assets/finallogo.png",
                            scale: 3,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              Container(
                                width: 32.w,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(0, 158, 158, 158),
                                ),
                                padding: const EdgeInsets.only(left: 8),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: DropdownButton<String>(
                                  elevation: 2,
                                  value: selectedValue,
                                  isExpanded: true,
                                  items: items?.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: isLightMode
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                  onChanged: (value) {
                                    print(value);
                                    onItemSelected(value);
                                    molo.onInit();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Switch_button(),
                              SizedBox(
                                width: 1.w,
                              ),
                              Dialog_myaccount(
                                  private_key: _pkey!, address: _address!),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    // Textfile(
                    //     text: "Account",
                    //     textcolor: isLightMode ? Colors.black : Colors.white,
                    //     textsize: 16.sp,
                    //     textweight: FontWeight.bold),
                    // SizedBox(
                    //   height: 0.3.h,
                    // ),

                    // SizedBox(
                    //   height: 0.2.h,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(bottom: padding / 20),
                      child: Container(
                        height: 155.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(0, 23, 233, 226),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                            color: isLightMode
                                ? Color.fromARGB(0, 102, 65, 65)
                                : Colors.black),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: padding / 100,
                              right: padding / 100,
                              //  top: 1,
                              bottom: padding / 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       decoration: BoxDecoration(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: isLightMode
                              //         ? Color.fromARGB(255, 138, 130, 130)
                              //             .withOpacity(0.5)
                              //         : Color.fromARGB(255, 110, 18, 153)
                              //             .withOpacity(0.5),
                              //     spreadRadius: 3,
                              //     blurRadius: 5,
                              //     offset: Offset(0, 3),
                              //   ),
                              // ],
                              //         borderRadius: BorderRadius.circular(50),
                              //       ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                //make border radius more than 50% of square height & width
                                child: Image.asset(
                                  "Assets/Mango Wallet.png",
                                  height: 30.w,
                                  width: 30.w,
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                              //     SizedBox(
                              //       width: 4.w,
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Textfile(
                              //               text:
                              //                   'Network ${prefs.getString('Symbol')}',
                              //               textcolor: isLightMode
                              //                   ? Colors.black
                              //                   : Colors.white,
                              //               textsize: 15.sp,
                              //               textweight: FontWeight.bold),
                              //           Obx(() => Textfile(
                              //                 text:
                              //                     'Balance ${MController.myNumber}',
                              //                 textcolor: isLightMode
                              //                     ? Colors.black
                              //                     : Colors.white,
                              //                 textsize: 14.sp,
                              //                 textweight: FontWeight.bold,
                              //               )),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // FadeAnimation(),
                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Obx(() => Textfile(
                                  text:
                                      '${MController.myNumber.toString().length > 5 ? (MController.myNumber).toStringAsFixed(4) : (MController.myNumber)}  ${prefs.getString('Symbol')}',
                                  textcolor:
                                      isLightMode ? Colors.black : Colors.white,
                                  textsize: 21.sp,
                                  textweight: FontWeight.bold)),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Icon(Icons.qr_code),
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              title: Text('QR Code'),
                                              content: Center(
                                                child: QrImage(
                                                  foregroundColor: isLightMode
                                                      ? Colors.white
                                                      : Colors.white,
                                                  data:
                                                      _address!, // set the data for the QR code
                                                  version: QrVersions.auto,
                                                  size: 200.0,
                                                ),
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  child: Text('Back'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86),
                                                  textColor: Colors.white,
                                                )
                                                // RoundedButton(
                                                //   Pressed: () {
                                                //     Navigator.of(context).pop();
                                                //   },
                                                //   Textcolor: isLightMode
                                                //       ? Colors.black
                                                //       : Colors.white,
                                                //   buttoncolor: Color.fromARGB(
                                                //       255, 241, 195, 86),
                                                //   buttontext: 'close',
                                                //   fontsize: 14,
                                                //   weightfont: FontWeight.normal,
                                                // ),
                                              ],
                                            );
                                          }),
                                      //  Get.to(QrScreen(data: _address!)),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SizedBox(
                                        height: 1.5.h,
                                        width: 22.w,
                                        child: Text(
                                          _address!.substring(0, 6) +
                                              '......' +
                                              _address!.substring(37, 42),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              color: isLightMode
                                                  ? Colors.black
                                                  : Colors.white),
                                        )),
                                    GestureDetector(
                                      onTap: () async {
                                        print(_pkey);
                                        //print(address);
                                        // print(WController.balance);
                                        Clipboard.setData(new ClipboardData(
                                                text: _address))
                                            .then((_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Copied to your clipboard')));
                                        });
                                      },
                                      child: Icon(
                                        Icons.copy,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DialogDeposit(address: _address!),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Dialog_SendCoin(
                                      pkey: _pkey!,
                                      from: address,
                                      bal:
                                          prefs.getDouble('balance').toString(),
                                      rpc: prefs.getString('rpcUrl').toString(),
                                      address: _address!),
                                  // SizedBox(
                                  //   width: 1.h,
                                  // ),
                                  // SizedBox(
                                  //   width: 1.h,
                                  // ),
                                  // Dialog_swap(
                                  //   pkey: _pkey!,
                                  //   from: _address!,
                                  //   bal: prefs.getDouble('balance').toString(),
                                  //   rpc: prefs.getString('rpcUrl').toString(),
                                  // ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Expanded(
                                child: Container(
                                  child: Tabbarfile(
                                      pkey: _pkey!,
                                      address: _address!,
                                      network: selectedValue.toString()),
                                ),
                              ),
                              // Expanded(
                              //   flex: , // default
                              //   child: Container(), // required field
                              // ),
                              // Expanded(
                              //   flex: 1, // Set flex to a non-zero value
                              //   child: Container(), // Your widget goes here
                              // ),
                              Textfile(
                                  text: "Don't see your token?",
                                  textcolor:
                                      isLightMode ? Colors.black : Colors.white,
                                  textsize: 14.sp,
                                  textweight: FontWeight.normal),
                              Dialog_Import_token(
                                  rpc: prefs.getString('rpcUrl').toString(),
                                  address: address),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Richtextfile(
                        text1: "Need Help? Contact",
                        text2: "Mango Wallet Support",
                        click: () {
                          //     print(listOfe);
                        },
                        text1color: isLightMode ? Colors.black : Colors.white,
                        text2color: Color.fromARGB(255, 241, 195, 86),
                        text1size: 13.sp,
                        text1weight: FontWeight.normal,
                        text2size: 13.sp,
                        text2weight: FontWeight.normal,
                        text1space: 1,
                        text2space: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> saveMyname(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('name', name);
}

Future<void> saveMyChainId(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('ChainId', name);
}

Future<void> saveMySymbol(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('Symbol', name);
}

Future<void> saveMyRpc(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('rpcUrl', name);
}

// Future<void> saveMyBalance(double balance) async {
//   final prefs = await SharedPreferences.getInstance();

//   prefs.setDouble('balance', balance);
// }
