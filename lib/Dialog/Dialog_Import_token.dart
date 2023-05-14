//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/Wallet_Controller.dart';
import 'package:sbgwallet/Controller/importToken_Controller.dart';
import 'package:sbgwallet/Controller/importsymbol.dart';
import 'package:sbgwallet/Controller/swap_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/NormalOutlinebutton.dart';
import '../Components/Richtextfile.dart';
import '../Components/Textfile.dart';
import '../Components/RoundedButton.dart';

class Dialog_Import_token extends StatelessWidget {
  final String rpc;
  final String address;
  Dialog_Import_token({required this.rpc, required this.address});

  @override
//  State<Dialog_Import_token> createState() => _Dialog_Import_tokenState();
//}

//class _Dialog_Import_tokenState extends State<Dialog_Import_token> {
  final _storage = FlutterSecureStorage();
  final myController = TextEditingController();
  String _rpc = '';
  String _address = '';
  bool _isDarkMode = false;

  @override
  void initState() {
    //super.initState();
    //  _loadData();
  }

  // Load data from SharedPreferences
  // void _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _rpc = prefs.getString('rpcUrl') ?? '';
  //     _address = prefs.getString('address') ?? '';
  //     _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TokenController TController = Get.put(TokenController());
    WalletController WController = Get.put(WalletController());
    swapController sc = Get.put(swapController());
    symbolController sycon = Get.put(symbolController());
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var padding = MediaQuery.of(context).size.width;

    return RichText(
        text: TextSpan(
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                Future.delayed(Duration(seconds: 2));
                print('asdsad');
                WController.fetchData();
              },
            text: "Refresh List",
            style: TextStyle(
                color: Color.fromARGB(255, 241, 195, 86),
                fontWeight: FontWeight.normal,
                fontSize: 14.sp),
            children: <InlineSpan>[
          WidgetSpan(
              child: SizedBox(
            width: 0.5.h,
          )),
          TextSpan(
              text: "Or",
              style: TextStyle(
                  color: isLightMode ? Colors.black : Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp)),
          WidgetSpan(
              child: SizedBox(
            width: 0.5.h,
          )),
          TextSpan(
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor:
                                isLightMode ? Color(0xffF5FAFA) : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Color.fromARGB(255, 241, 195, 86),
                                // isLightMode
                                // ? Color.fromARGB(255, 241, 195, 86)
                                // : Color(0xffFFB800)
                              ),
                            ),
                            actions: [
                              Container(
                                height: 36.h,
                                width: 80.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Textfile(
                                        text: "Import Token",
                                        textcolor: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                        textsize: 18.sp,
                                        textweight: FontWeight.bold),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: padding / 20,
                                          right: padding / 20),
                                      child: Richtextfile(
                                          text1:
                                              "Token detection is not available on this network yet. Please import token manually and make sure you trust it. Learn about scams and security risks.",
                                          text2: "Here",
                                          click: () {},
                                          text1color: isLightMode
                                              ? Colors.black
                                              : Colors.white,
                                          text2color:
                                              Color.fromARGB(255, 241, 195, 86),
                                          text1size: 12.sp,
                                          text1weight: FontWeight.normal,
                                          text2size: 12.sp,
                                          text2weight: FontWeight.normal,
                                          text1space: 1,
                                          text2space: 1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: padding / 20,
                                          right: padding / 20,
                                          top: padding / 40),
                                      child: SizedBox(
                                        height: 10.h,
                                        width: 64.w,
                                        child: SingleChildScrollView(
                                          child: TextFormField(
                                            maxLines: null,
                                            onChanged: (value) async => {
                                              print(value.length),
                                              if (value.length == 42)
                                                {
                                                  print(rpc),
                                                  print(address),
                                                  sycon.fetchData(
                                                      rpc.toString(),
                                                      address,
                                                      await myController.text
                                                          .toString())
                                                }
                                              else
                                                {sycon.clearOutputData()}
                                            },
                                            controller: myController,
                                            decoration: InputDecoration(
                                                hintText: "Token",
                                                hintStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: isLightMode
                                                        ? Colors.black
                                                        : Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              241,
                                                              195,
                                                              86),
                                                          //  isLightMode
                                                          // ? Color.fromARGB(255, 241, 195, 86)
                                                          // : Color(0xffFFB800)
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff17E9E1),
                                                            //   isLightMode
                                                            // ? Color.fromARGB(255, 241, 195, 86)
                                                            // : Color(0xffFFB800),
                                                            width: 2))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Obx(
                                      () => SizedBox(
                                        height: 5.h,
                                        width: 64.w,
                                        child: NormalOutlineButton(
                                          buttontext: sycon.outputData.value,
                                          pressed: () {
                                            myController.clear();
                                          },
                                          textcolor: isLightMode
                                              ? Colors.black
                                              : Colors.white,
                                          buttonwidth: 1,
                                          buttoncolor:
                                              Color.fromARGB(255, 241, 195, 86),
                                          //  isLightMode
                                          //           ? Color.fromARGB(255, 241, 195, 86)
                                          //           : Color(0xffFFB800)
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding:  EdgeInsets.only(left:padding/20,right:padding/20),
                                    //   child: SizedBox(
                                    //     height: 5.h,
                                    //     child: TextFormField(
                                    //       decoration: InputDecoration(
                                    //         hintText: "Token",
                                    //         hintStyle: TextStyle(
                                    //           fontSize: 14.sp
                                    //         ),
                                    //         enabledBorder: OutlineInputBorder(
                                    //           borderSide: BorderSide(
                                    //            color: Color.fromARGB(255, 241, 195, 86),
                                    //           ),
                                    //           borderRadius: BorderRadius.circular(10)
                                    //         ),
                                    //         focusedBorder: OutlineInputBorder(
                                    //           borderRadius: BorderRadius.circular(10),
                                    //           borderSide: BorderSide(
                                    //             color: Color.fromARGB(255, 241, 195, 86),
                                    //             width: 2
                                    //           )
                                    //         )
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 4.5.h,
                                          width: 25.w,
                                          child: NormalOutlineButton(
                                            buttontext: 'Cancel',
                                            pressed: () {
                                              sycon.clearOutputData();

                                              myController.clear();
                                              Navigator.pop(context);
                                            },
                                            textcolor: Color.fromARGB(
                                                255, 241, 195, 86),
                                            // isLightMode
                                            //     ? Color.fromARGB(255, 241, 195, 86)
                                            //     : Color(0xffFFB800),
                                            textsize: 14.sp,
                                            textweight: FontWeight.normal,
                                            buttoncolor: Color.fromARGB(
                                                255, 241, 195, 86),
                                            // isLightMode
                                            //     ? Color.fromARGB(255, 241, 195, 86)
                                            //     : Color(0xffFFB800),
                                            buttonwidth: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.h,
                                        ),
                                        SizedBox(
                                          height: 4.5.h,
                                          width: 25.w,
                                          child: RoundedButton(
                                              buttontext: "Import",
                                              buttoncolor: Color.fromARGB(
                                                  255, 241, 195, 86),
                                              //  isLightMode
                                              //         ? Color.fromARGB(255, 241, 195, 86)
                                              //         : Color(0xffFFB800),
                                              Textcolor: Colors.black,
                                              weightfont: FontWeight.normal,
                                              Pressed: () async {
                                                String? address = await _storage
                                                    .read(key: 'address');
                                                final SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                if (await TController.fetch(
                                                        await prefs.getString(
                                                            'rpcUrl'),
                                                        '$address',
                                                        await myController.text
                                                            .toString()
                                                        // '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c'
                                                        ) ==
                                                    'success') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Token Recieved!')));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Not Recieved !')));
                                                }
                                                ;

                                                String? pk = await _storage
                                                    .read(key: 'privatekey');
                                                String? phrase = await _storage
                                                    .read(key: 'phrase');
                                                print(WController
                                                    .balance.runtimeType);
                                                String phrases = '';

                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  CircularProgressIndicator(
                                                      color: Color.fromARGB(
                                                          255, 241, 195, 86));
                                                  sycon.clearOutputData();
                                                  myController.clear();
                                                  WController.fetchData();
                                                  sc.fetchToken();
                                                }).then((value) => Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/home',
                                                        arguments: [
                                                          phrases,
                                                          address,
                                                          pk
                                                        ],
                                                        (Route<dynamic>
                                                                route) =>
                                                            false));
                                              },
                                              fontsize: 14.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                },
              text: "Import token",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 195, 86),
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp))
        ]));
  }
}
