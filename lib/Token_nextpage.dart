import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbgwallet/token_details.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Richtextfile.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dialog/Dialog_DepositETH.dart';
import 'Dialog/Dialog_Send.dart';

class Token_Next_Page extends StatefulWidget {
  final String balance;
  final String symbol;
  final String tokenAddress;
  final String walletAddress;
  final String rpc;
  final String pkey;
  final String network;

  const Token_Next_Page(
      {super.key,
      required this.balance,
      required this.symbol,
      required this.tokenAddress,
      required this.walletAddress,
      required this.rpc,
      required this.pkey,
      required this.network});

  @override
  State<Token_Next_Page> createState() => _Token_Next_PageState();
}

class _Token_Next_PageState extends State<Token_Next_Page> {
//  final WalletModel wallet;
  bool _showDialog = false;
  @override
  String _rpc = '';
  String _address = '';
  bool _isDarkMode = false;
  double _balance = 0.0;
  String _key = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load data from SharedPreferences
  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _rpc = prefs.getString('rpcUrl') ?? '';
      _address = prefs.getString('address') ?? '';
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _balance = prefs.getDouble('balance') ?? 0.0;
      _key = prefs.getString('pkey') ?? '';
    });
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Widget build(BuildContext context) {
    final _storage = FlutterSecureStorage();

    // final List? arguments = Get.arguments;
    // final String balance = (arguments?[0] ?? ' ') as String;
    // final String symbol = (arguments?[3] ?? ' ') as String;
    // final String tokenAddress = (arguments?[2] ?? ' ') as String;
    // final String walletAddress = (arguments?[1] ?? ' ') as String;
    // final String rpc = (arguments?[4] ?? ' ') as String;
    // final String pkey = (arguments?[5] ?? ' ') as String;
    // final String network = (arguments?[6] ?? ' ') as String;

    var padding = MediaQuery.of(context).size.height;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        // scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      },
      child: Scaffold(
        // key: scaffoldMessengerKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: padding / 40,
                right: padding / 40,
                bottom: padding / 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "Assets/finallogo.png",
                        scale: 3,
                      ),
                      // Switch_button(),
                      SizedBox(
                        width: 1.w,
                      ),
                      InkWell(
                        child: Icon(Icons.menu),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: isLightMode
                                    ? Color(0xffF5FAFA)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text(
                                  'Token',
                                  style: TextStyle(
                                    color: isLightMode
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Block Explorer',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 241, 195, 86)),
                                    ),
                                    onPressed: () async {
                                      if (await canLaunchUrl(Uri.parse(
                                          'https://bscscan.com/address/${widget.tokenAddress}'))) {
                                        await launchUrl(Uri.parse(
                                            'https://bscscan.com/address/${widget.tokenAddress}'));
                                      } else {
                                        throw 'Could not launch ';
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Token Details',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 241, 195, 86)),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           TokenDetailsPage(
                                      //             tokenSymbol: symbol,
                                      //             tokenName: network,
                                      //             tokenPrice: balance,
                                      //             address: tokenAddress,
                                      //           )),
                                      // );
                                      Get.to(() => TokenDetailsPage(
                                            tokenSymbol: widget.symbol,
                                            tokenName: widget.network,
                                            tokenPrice: widget.balance,
                                            address: widget.tokenAddress,
                                          ));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // _showTwoButtonDialog(context, (String result) {
                          //   print('User selected $result');
                          // }, 'https://bscscan.com/address/${tokenAddress}',
                          //     symbol, network, tokenAddress, balance);
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 65.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(0, 23, 233, 226),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          //make border radius more than 50% of square height & width
                          child: Image.asset(
                            "Assets/Mango Wallet.png",
                            height: 28.w,
                            width: 28.w,
                            fit: BoxFit.cover, //change image fill type
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Textfile(
                                text:
                                    '${double.parse(widget.balance).toStringAsFixed(double.parse(widget.balance).truncateToDouble() == double.parse(widget.balance) ? 0 : 4)}',
                                textcolor:
                                    isLightMode ? Colors.black : Colors.white,
                                textsize: 18.sp,
                                textweight: FontWeight.bold),
                            SizedBox(
                              height: 10.h,
                            ),
                            Textfile(
                                text: widget.symbol,
                                textcolor:
                                    isLightMode ? Colors.black : Colors.white,
                                textsize: 16.sp,
                                textweight: FontWeight.bold),
                          ],
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
                              SizedBox(
                                  height: 1.8.h,
                                  width: 22.w,
                                  child: Text(
                                    widget.walletAddress,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white),
                                  )

                                  // Textfile(
                                  //     text: address,
                                  //     textcolor: isLightMode ? Colors.black : Colors.white,
                                  //     textsize: 14.sp,
                                  //     textweight: FontWeight.normal),
                                  ),
                              GestureDetector(
                                onTap: () async {
                                  //     print(address);
                                  print(_key);
                                  print(widget.tokenAddress);
                                  print(widget.walletAddress);
                                  print(widget.pkey);
                                  print(widget.network);
                                  print(widget.rpc);
                                  // print(WController.balance);
                                  Clipboard.setData(new ClipboardData(
                                          text: widget.walletAddress))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Copied to your clipboard !')));
                                  });
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 0.2.h,
                        // ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DialogDeposit(
                              address: widget.walletAddress,
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            Dialog_Send(
                              balance: widget.balance,
                              symbol: widget.symbol,
                              walleta: widget.walletAddress,
                              tokena: widget.tokenAddress,
                              rpc: widget.rpc,
                              pkey: widget.pkey,
                            ),
                            // Dailog_quickpaytoken(
                            //   balance: widget.balance,
                            //   symbol: widget.symbol,
                            //   walleta: widget.walletAddress,
                            //   tokena: widget.tokenAddress,
                            //   rpc: widget.rpc,
                            //   pkey: widget.pkey,
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.build,
                              color: isLightMode ? Colors.black : Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            Textfile(
                                text: "Portfolio Site",
                                textcolor:
                                    isLightMode ? Colors.black : Colors.white,
                                textsize: 14.sp,
                                textweight: FontWeight.normal),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        // Textfile(
                        //     text: "You Have no Transactions",
                        //     textcolor: isLightMode ? Colors.black : Colors.white,
                        //     textsize: 16.sp,
                        //     textweight: FontWeight.normal),
                        SizedBox(
                          height: 7.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Richtextfile(
                      text1: "Need Help? Contect",
                      text2: "Mango Wallet Support",
                      click: () {},
                      text1color: isLightMode ? Colors.black : Colors.white,
                      text2color: Color.fromARGB(255, 241, 195, 86),
                      text1size: 13.sp,
                      text1weight: FontWeight.normal,
                      text2size: 13.sp,
                      text2weight: FontWeight.normal,
                      text1space: 1,
                      text2space: 1)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//   void _showTwoButtonDialog(BuildContext context, Function callback, String url,
//       String symbol, String network, String tokenAddress, String balance) {
//     final isLightMode = Theme.of(context).brightness == Brightness.light;

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 20.h,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: Color.fromARGB(255, 241, 195, 86))),
//               backgroundColor: isLightMode ? Color(0xffF5FAFA) : Colors.black,
//               content: Column(
//                 children: [
//                   TextButton(
//                     child: Text(
//                       'View on block explorer',
//                       style: TextStyle(
//                           color: isLightMode ? Colors.black : Colors.white),
//                     ),
//                     onPressed: () async {
//                       //  const url = 'https://www.example.com';
//                       if (await canLaunchUrl(Uri.parse(url))) {
//                         await launchUrl(Uri.parse(url));
//                       } else {
//                         throw 'Could not launch $url';
//                       }
//                     },
//                   ),
//                   TextButton(
//                     child: Text(
//                       'Token Details',
//                       style: TextStyle(
//                           color: isLightMode ? Colors.black : Colors.white),
//                     ),
//                     onPressed: () async {
//                       //  const url = 'https://www.example.com';
//                       Get.to(TokenDetailsPage(
//                         tokenSymbol: '',
//                         tokenName: '',
//                         tokenPrice: '',
//                         address: '',
//                       ));
//                     },
//                   ),
//                 ],
//               ),
//               // actions: [

//               // ],
//             ),
//           );
//         });
//   }
}
