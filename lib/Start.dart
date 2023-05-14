//import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Richtextfile.dart';
import 'package:sbgwallet/WalletPage_assets.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'Controller/Wallet_Controller.dart';
import 'Terms_Screen.dart';
import 'Components/Textfile.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}
// bool _icon = false;

// IconData _Lighticon = Icons.wb_sunny;
// IconData _Darkicon  = Icons.nights_stay;

class _StartState extends State<Start> {
  bool isFinished = false;
  final storage = FlutterSecureStorage();
  WalletController WController = Get.put(WalletController());

  Future<void> _checkPassword(BuildContext context) async {
    final password = await storage.read(key: 'password');
    final accexist = await storage.read(key: 'accountexist');
    if (password == null || accexist == null) {
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

      await storage.write(key: 'balance', value: jsonEncode(balance));
      await storage.write(
          key: 'transactionHash', value: jsonEncode(trasactionhash));
      await storage.write(
          key: 'transactioncoinhash', value: jsonEncode(trasactioncoinhash));
      await storage.write(
          key: 'token_address', value: jsonEncode(token_address));
      await storage.write(
          key: 'wallet_address', value: jsonEncode(wallet_address));
      await storage.write(key: 'symbol', value: jsonEncode(symbol));
      await storage.write(key: 'rpc', value: jsonEncode(rpc));
      await storage.write(key: 'chainBalance', value: jsonEncode(chainbalance));
      Get.to(Terms_screen());
    } else {
      final address = await storage.read(key: 'address');
      final privatekey = await storage.read(key: 'privatekey');
      if (address == null && privatekey == null) {
        await Get.to(Terms_screen());
      } else {
        // final phrases = await storage.read(key: 'phrase');
        //final address = await storage.read(key: 'address');
        //final privatekey = await storage.read(key: 'privatekey');
        final String phrases = await '';

        // Get.to(WalletPage_asset(), arguments: [phrase, address, privatekey]);
        // Password set, move to login screen
        while (true) {
          final input = await _getPassword(context);
          if (input == null) {
            // User cancelled password input, do nothing
            break;
          } else if (input == password) {
            // final String phrases = '';
            // //  await WController.fetchData();
            // //    final phrases = await storage.read(key: 'phrase');
            // final address = await storage.read(key: 'address');
            // final privatekey = await storage.read(key: 'privatekey');
            print('hi');
            print(address);
            print('hi');
            Get.offAll(WalletPage_asset(),
                arguments: [phrases, address, privatekey]);
            break;
          } else {
            // Show error message if password is incorrect
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Incorrect password')),
            );
          }
        }
      }
    }
  }

//sheroze
  Future<String?> _getPassword(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (_) => PasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _checkPassword(context);

    //  No password set, move to setup screen
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark
    //           ? 'DarkTheme'
    //           : 'LightTheme';
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var padding = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/bgmain.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 198, 191, 191),
        body: Padding(
          padding: EdgeInsets.only(
              top: padding / 12,
              left: padding / 20,
              right: padding / 20,
              bottom: padding / 20),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 800),
                    firstChild: Container(
                      color: Colors.white,
                    ),
                    secondChild: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      //make border radius more than 50% of square height & width
                      child: Image.asset(
                        "Assets/Mango Wallet.png",
                        height: 40.w,
                        width: 40.w,
                        fit: BoxFit.cover, //change image fill type
                      ),
                    ),
                    crossFadeState: CrossFadeState.showSecond,
                    firstCurve: Curves.easeOut,
                    secondCurve: Curves.easeIn,
                    sizeCurve: Curves.bounceInOut,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Animate(
                    effects: [
                      FadeEffect(delay: 1000.ms),
                      SlideEffect(delay: 1000.ms)
                    ],
                    child: Textfile(
                      text: 'Welcome to Mango Wallet',
                      textcolor: Colors.black,
                      textsize: 22.sp,
                      textweight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Center(
                      child: Animate(
                        effects: [
                          FadeEffect(delay: 1000.ms),
                          SlideEffect(delay: 1000.ms)
                        ],
                        child: Richtextfile(
                          text1: "Start Investing",
                          text2:
                              "Today and your Future will change for the better",
                          click: () {},
                          text1color: Color.fromARGB(255, 241, 195, 86),
                          text2color: isLightMode ? Colors.black : Colors.black,
                          text1size: 16.sp,
                          text1weight: FontWeight.normal,
                          text2size: 16.sp,
                          text2weight: FontWeight.normal,
                          text1space: 1,
                          text2space: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: padding / 20),
                    child: SizedBox(
                      height: 5.2.h,
                      width: 48.w,
                      child: SwipeableButtonView(
                        buttonText: "Let\'s Start",
                        buttontextstyle: TextStyle(color: Colors.black),
                        buttonWidget: Container(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ),
                        activeColor: Color.fromARGB(255, 241, 195, 86),
                        isFinished: isFinished,
                        onWaitingProcess: () {
                          Future.delayed(Duration(milliseconds: 3), () {
                            setState(() {
                              isFinished = true;
                            });
                          });
                        },
                        onFinish: () async {
                          await _checkPassword(context);
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Terms_screen()),
                          // );

                          //TODO: For reverse ripple effect animation
                          setState(() {
                            isFinished = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({Key? key}) : super(key: key);

  @override
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var padding = MediaQuery.of(context).size.width;

    return AlertDialog(
        backgroundColor: isLightMode
            ? Color.fromARGB(0, 245, 250, 250)
            : Color.fromARGB(0, 0, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Color.fromARGB(255, 241, 195, 86),
            // title: Text('Enter Password'),
            // content: TextField(
            //   controller: _controller,
            //   obscureText: true,

            //   decoration: InputDecoration(

            //     hintText: 'Password',
            //   ),
            // ),
          ),
        ),
        actions: [
          Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(0, 255, 255, 255)),
              height: 28.h,
              width: 95.w,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "Assets/front.png",
                      width: 30.w,
                      height: 15.w,
                    ).animate(delay: 600.ms).scaleX(),
                    // Textfile(
                    //     text: "Password",
                    //     textcolor: isLightMode ? Colors.black : Colors.white,
                    //     textsize: 18.sp,
                    //     textweight: FontWeight.bold),
                    TextField(
                        controller: _controller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 241, 195, 86),
                            ), // set the underline color
                          ),
                        )),
                  ])),
          // TextButton(
          //   onPressed: () {
          //     Navigator.pop(context, null);
          //   },
          //   child: Text('Cancel' , style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal , color: isLightMode ? Colors.black :Colors.white),),
          // ),
          TextButton(
            onPressed: () {
              final password = _controller.text.trim();
              if (password.isNotEmpty) {
                Navigator.pop(context, password);
              }
            },
            child: Text(
              'Ok',
              style:
                  TextStyle(color: isLightMode ? Colors.black : Colors.white),
            ),
          ),
        ]);
  }
}
