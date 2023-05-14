//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/Wallet_Controller.dart';
import '../Controller/rpc_Controller.dart';
import '../Token_nextpage.dart';

class Tabbarfile extends StatefulWidget {
  final String pkey;
  final String address;
  final String network;
  Tabbarfile(
      {required this.pkey, required this.address, required this.network});
  WalletController walletController = Get.put(WalletController());
  MyController123 m = Get.put(MyController123());
  @override
  State<Tabbarfile> createState() => _TabbarfileState();
}

class _TabbarfileState extends State<Tabbarfile> with TickerProviderStateMixin {
  WalletController walletController = Get.put(WalletController());
  bool _isLoading = true;
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    await walletController.fetchData();
  }

  @override
  void initState() {
    super.initState();

    // Use Future.delayed to delay the display of the ListView.builder
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _storage = FlutterSecureStorage();
    // var a=_storage.read(key: 'balance');
    // var b= _storage.read(key: 'token_address');
    // var c= _storage.read(key: 'wallet_address');
    // var d= _storage.read(key: 'symbol');
    // var e= _storage.read(key: 'rpc');
    var p = _storage.read(key: 'privatekey');
    //  var balance=jsonDecode(a.toString());
    // var token_address=jsonDecode(b.toString());

    //  var wallet_address=jsonDecode(c.toString());
    //  var symbol=jsonDecode(d.toString());
    //  var rpc=jsonDecode(e.toString());
    //  print(rpc[0]);

    TabController _tabController = TabController(length: 2, vsync: this);
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var padding = MediaQuery.of(context).size.width;
    MyController123 m = Get.put(MyController123());

    return Scaffold(
      body: Container(
        width: padding,
        color: isLightMode ? Colors.white : Colors.black,
        child: Column(
          children: [
            TabBar(
                indicatorColor: Color.fromARGB(255, 241, 195, 86),
                controller: _tabController,
                labelColor: isLightMode ? Colors.black : Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: "Assets",
                  ),
                  Tab(
                    text: "NFT",
                  )
                ]),
            Expanded(
              child: Container(
                // width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  RefreshIndicator(
                    onRefresh: refreshList,
                    backgroundColor: Color.fromARGB(255, 241, 195, 86),
                    color: isLightMode ? Color(0xffF5FAFA) : Colors.white,
                    child: GetBuilder<WalletController>(builder: (controller) {
                      return _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 241, 195, 86)),
                            )
                          :
                          //   var a = _storage.read(key: 'balance');

                          Obx(
                              () => ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: walletController.balance.length,
                                  itemBuilder: (_, i) {
                                    var entry = walletController
                                        .walletToDataMap.entries
                                        .elementAt(i);

                                    // Get the data values from the map entry
                                    var wallet = entry.value['token_address'];
                                    var symbolData = entry.value['symbol'];
                                    var rpcData = entry.value['rpc'];
                                    var balanceData = entry.value['balance'];
                                    print(symbolData);
                                    print(rpcData);
                                    print(m.desiredRpcValue.value);
                                    if (rpcData ==
                                        m.desiredRpcValue.value.toString()) {
                                      print('hihihihihih');
                                      return GestureDetector(
                                        onTap: () async {
                                          String? myValue = await _storage.read(
                                              key: 'privatekey');
                                          //print(myValue);
                                          late SharedPreferences prefs;
                                          prefs = await SharedPreferences
                                              .getInstance();

                                          print(
                                              await prefs.getString('address'));
                                          Get.to(
                                              () => Token_Next_Page(
                                                    balance: walletController
                                                        .balance[i]
                                                        .toString(),
                                                    walletAddress:
                                                        widget.address,
                                                    tokenAddress:
                                                        walletController
                                                            .token_address[i]
                                                            .toString(),
                                                    symbol: walletController
                                                        .symbol[i]
                                                        .toString(),
                                                    rpc: walletController.rpc[i]
                                                        .toString(),
                                                    pkey: widget.pkey,
                                                    network: widget.network,
                                                  ),
                                              transition: Transition.native,
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              arguments: [
                                                walletController.balance[i]
                                                    .toString(),

                                                // walletController.wallet_address[i]
                                                widget.address,
                                                walletController
                                                    .token_address[i]
                                                    .toString(),
                                                //     .toString(),
                                                walletController.symbol[i]
                                                    .toString(),
                                                walletController.rpc[i]
                                                    .toString(),
                                                myValue = await _storage.read(
                                                    key: 'privatekey'),
                                                widget.network
                                              ]);
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        //make border radius more than 50% of square height & width
                                                        child: Image.asset(
                                                          "Assets/icon.png",
                                                          height: 38.0,
                                                          width: 38.0,
                                                          fit: BoxFit
                                                              .cover, //change image fill type
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Obx(() => Textfile(
                                                            text:
                                                                walletController
                                                                    .symbol[i]
                                                                    .toString(),
                                                            textcolor:
                                                                isLightMode
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                            textsize: 17.sp,
                                                            textweight:
                                                                FontWeight
                                                                    .bold)),
                                                        Obx(() => Textfile(
                                                            text:
                                                                "${walletController.balance[i]}",
                                                            textcolor:
                                                                isLightMode
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                            textsize: 14.sp,
                                                            textweight:
                                                                FontWeight
                                                                    .normal)),
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  }),
                            );
                      // return CircularProgressIndicator(color:Color.fromARGB(                                                         255, 241, 195, 86));
                    }),
                  ),

                  Center(
                    child: Text('No NFTs yet'),
                  )
                  // GridView.count(
                  //   crossAxisCount: 3,
                  //   crossAxisSpacing: 5,
                  //   mainAxisSpacing: 5,
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT1-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT2-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT1-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT2-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT2-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT1-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT1-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT2-min.jpg"))),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //               image: AssetImage("Assets/NFT1-min.jpg"))),
                  //     ),
                  //   ],
                  // ),
                  //   Text("",
                  //  style: TextStyle(
                  //   color: Colors.black
                  //  )),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  // Obx(
                    //   () => ListView.builder(
                    //       scrollDirection: Axis.vertical,
                    //       itemCount: walletController.network_name.length,
                    //       itemBuilder: (_, i) {
                    //         // List a=[walletController.balance[i].toString(),
                    //         // walletController.token_address[i].toString(),
                    //         // walletController.wallet_address[i].toString(),
                    //         // walletController.symbol[i].toString(),walletController.rpc[i].toString(),];
                    //         // var currentWallet = walletController.balance[i];
                    //         return Column(
                    //           children: [
                    //             SizedBox(
                    //               height: 2.h,
                    //             ),
                    //             Container(
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(10)),
                    //                 child: Row(
                    //                   children: [
                    //                     Image.asset(
                    //                       "Assets/logo.png",
                    //                       scale: 49,
                    //                     ),
                    //                     SizedBox(
                    //                       width: 4.w,
                    //                     ),
                    //                     Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Obx(() => Textfile(
                    //                             text: walletController
                    //                                 .network_name[i]
                    //                                 .toString(),
                    //                             textcolor: isLightMode
                    //                                 ? Colors.black
                    //                                 : Colors.white,
                    //                             textsize: 17.sp,
                    //                             textweight: FontWeight.bold)),
                    //                         Obx(() => Textfile(
                    //                             text:
                    //                                 "${walletController.network_name[i]}",
                    //                             textcolor: isLightMode
                    //                                 ? Colors.black
                    //                                 : Colors.white,
                    //                             textsize: 14.sp,
                    //                             textweight: FontWeight.normal)),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ))
                    //           ],
                    //         );
                    //       }),
                    // )