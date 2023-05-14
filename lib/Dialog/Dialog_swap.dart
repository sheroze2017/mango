import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/swap_Controller.dart';
import 'package:sbgwallet/swapScreen.dart';

import '../Components/Textfile.dart';

class Dialog_swap extends StatefulWidget {
  final String pkey;

  final String from;

  final String bal;

  final String rpc;

  Dialog_swap(
      {required this.pkey,
      required this.from,
      required this.bal,
      required this.rpc});

  @override
  State<Dialog_swap> createState() => _Dialog_swapState();
}

class _Dialog_swapState extends State<Dialog_swap> {
  TextEditingController recieveAddress = TextEditingController(text: "");

  swapController SController = Get.put(swapController());

  TextEditingController excfrom = TextEditingController();

  TextEditingController currfrom = TextEditingController();

  TextEditingController currto = TextEditingController();
//  CounterController IDController = Get.put(CounterController());

  TextEditingController excto = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  String? selectedValuefrom;
  void onexecfrom(String? newValue) {
    setState(() {
      selectedValuefrom = newValue!;
    });
  }

  String? selectedValueto;

  void onexecto(String? newValue) {
    setState(() {
      selectedValueto = newValue!;
    });
  }

  double? selectedcurrto;
  void currtoo(double? newValue) {
    setState(() {
      selectedcurrto = newValue!;
    });
  }

  double? selectedcurrfrom;
  void currfromm(double? newValue) {
    setState(() {
      selectedcurrfrom = newValue!;
    });
  }

  List<String>? items = [
    'ETH',
    'BNB',
    'AVAX',
    'MATIC',
    'MMIT',
    'BGVT',
    'ZAX',
    'ETH',
    'BNB',
    'AVAX',
    'MATIC',
    'MMIT',
    'BGVT',
    'ZAX'
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   _textEditingController2.addListener(_onTextChanged);
  // }

  // @override
  // void dispose() {
  //   _textEditingController2.removeListener(_onTextChanged);
  //   super.dispose();
  // }

  // void _onTextChanged() {
  //   setState(() {
  //     _textEditingController1.text = SController.outputDataFrom.toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //sendC sendcoin_Controller = Get.put(sendC());
    // CounterController IDController = Get.put(CounterController());
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        IconButton(
            onPressed: () {
              // showDialog(
              //     context: context,
              //     builder: (context) => AlertDialog(
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10),
              //               side: BorderSide(color: Color.fromARGB(255, 241, 195, 86)
              //                   //  isLightMode
              //                   //  ? Color.fromARGB(255, 241, 195, 86)
              //                   //  : Color(0xffFFB800)
              //                   )),
              //           backgroundColor:
              //               isLightMode ? Color(0xffF5FAFA) : Colors.black,
              //           content: StatefulBuilder(builder:
              //               (BuildContext context, StateSetter setState) {
              //             return SingleChildScrollView(
              //                 child: Container(
              //                     height: 80.h,
              //                     width: 95.w,
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                     ),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Padding(
              //                               padding: EdgeInsets.only(
              //                                   left: padding / 40),
              //                               child: Textfile(
              //                                   text: "Swap",
              //                                   textcolor: isLightMode
              //                                       ? Colors.black
              //                                       : Colors.white,
              //                                   textsize: 18.sp,
              //                                   textweight: FontWeight.bold),
              //                             ),
              //                             IconButton(
              //                                 onPressed: () async {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 icon: Icon(Icons.cancel,
              //                                     color: Color.fromARGB(255, 241, 195, 86))),
              //                           ],
              //                         ),
              //                         Divider(
              //                             thickness: 2,
              //                             color: Color.fromARGB(255, 241, 195, 86)),
              //                         SizedBox(height: 0.5.h),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Textfile(
              //                                 text: 'From',
              //                                 textsize: 18.sp,
              //                                 textweight: FontWeight.bold),
              //                             // Obx(
              //                             //   () =>
              //                             Container(
              //                               width: 100,
              //                               height: 40,
              //                               decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(8),
              //                                 color: Colors.grey,
              //                               ),
              //                               padding:
              //                                   const EdgeInsets.only(left: 20),
              //                               margin: const EdgeInsets.symmetric(
              //                                   vertical: 16),
              //                               child: DropdownButton<String>(
              //                                 menuMaxHeight: 30.h,
              //                                 value: selectedValuefrom,
              //                                 elevation: 2,
              //                                 isExpanded: true,
              //                                 items: SController.uniqueList
              //                                     .map((String item) {
              //                                   return DropdownMenuItem<String>(
              //                                     value: item,
              //                                     child: Text(
              //                                       item,
              //                                       style: TextStyle(
              //                                         fontSize: 14,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: isLightMode
              //                                             ? Colors.black
              //                                             : Colors.white,
              //                                       ),
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                     ),
              //                                   );
              //                                 }).toList(),
              //                                 onChanged: (String? value) async {
              //                                   setState(() {
              //                                     selectedValuefrom = value!;
              //                                   });
              //                                   //onexecfrom(await value);
              //                                   print(value);
              //                                   SController.isLoading.value =
              //                                       await false;
              //                                   print(await SController
              //                                       .isLoading.value);
              //                                   SController.clearOutputDataTo();
              //                                   SController
              //                                       .clearOutputDataFrom();
              //                                   SController.clearOutputDataTo();
              //                                   IDController.setValuein(0.0);
              //                                   IDController.setValueout(0.0);
              //                                   _textEditingController2.clear();
              //                                 },
              //                               ),
              //                             ),
              //                             //  ),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 1.h,
              //                         ),
              //                         Row(
              //                           children: [
              //                             SizedBox(
              //                               width: 45.w,
              //                               height: 10.h,
              //                               child: TextField(
              //                                 onTap: () async {
              //                                   // print('fsdf');
              //                                   // print(
              //                                   //     IDController.INcounter.value);
              //                                   if (IDController
              //                                               .INcounter.value ==
              //                                           0 &&
              //                                       SController
              //                                               .isLoading.value ==
              //                                           true) {
              //                                     print('111111');
              //                                     SController.isLoading.value =
              //                                         await false;
              //                                     print(await SController
              //                                         .isLoading.value);
              //                                     SController
              //                                         .clearOutputDataTo();
              //                                     SController
              //                                         .clearOutputDataFrom();
              //                                     SController
              //                                         .clearOutputDataTo();
              //                                     IDController.setValuein(0.0);
              //                                     IDController.setValueout(0.0);
              //                                     _textEditingController2
              //                                         .clear();
              //                                     print(SController
              //                                         .isLoading.value);
              //                                   }
              //                                 },
              //                                 onChanged: (value) async {
              //                                   SController.outputDataFrom
              //                                       .value = value.toString();
              //                                   IDController.setValuein(
              //                                       double.parse(value));
              //                                   print('ok');
              //                                   if (SController
              //                                               .isLoading.value ==
              //                                           false &&
              //                                       selectedValuefrom != null &&
              //                                       selectedValueto != null) {
              //                                     var sym = [
              //                                       'BNB',
              //                                       'ETH',
              //                                       'MATIC',
              //                                       'AVAX'
              //                                     ];
              //                                     // print(selectedValuefrom);
              //                                     // print(selectedValueto);
              //                                     // print(selectedcurrto);
              //                                     // print(selectedcurrfrom);
              //                                     var a = await SController
              //                                         .tokenCoin
              //                                         .indexOf(
              //                                             selectedValuefrom);
              //                                     var b = await SController
              //                                         .tokenCoin
              //                                         .indexOf(selectedValueto);
              //                                     print(SController.rpccoin[a]
              //                                         .toString());
              //                                     print(SController
              //                                         .tokenAddress[a]
              //                                         .toString());
              //                                     print(SController
              //                                         .tokenAddress[b]
              //                                         .toString());
              //                                     print(value.toString());
              //                                     SController.fetchData(
              //                                         SController.rpccoin[a]
              //                                             .toString(),
              //                                         SController
              //                                             .tokenAddress[a]
              //                                             .toString(),
              //                                         SController
              //                                             .tokenAddress[b]
              //                                             .toString(),
              //                                         value.toString());
              //                                     SController.isLoading.value =
              //                                         true;
              //                                   } else if (SController
              //                                           .isLoading ==
              //                                       true) {
              //                                     print(value);
              //                                     SController.multiple(
              //                                         double.parse(value));
              //                                   }
              //                                 },
              //                                 keyboardType:
              //                                     TextInputType.number,
              //                                 controller:
              //                                     _textEditingController1,
              //                                 decoration: InputDecoration(
              //                                   hintText: 'Enter Amount',
              //                                 ),
              //                               ),
              //                             ),
              //                             Column(
              //                               children: [
              //                                 IconButton(
              //                                     iconSize: 15,
              //                                     icon: Icon(Icons.add),
              //                                     onPressed: () async {
              //                                       IDController.incrementin();
              //                                       _textEditingController1
              //                                               .text =
              //                                           await IDController
              //                                                   .INcounter
              //                                               .toString();
              //                                     }),
              //                                 IconButton(
              //                                     iconSize: 15,
              //                                     icon: Icon(Icons.remove),
              //                                     onPressed: () async {
              //                                       IDController.decrementin();
              //                                       _textEditingController1
              //                                               .text =
              //                                           await IDController
              //                                                   .INcounter
              //                                               .toString();
              //                                     }),
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                         Obx(
              //                           () => Padding(
              //                             padding:
              //                                 const EdgeInsets.only(left: 8.0),
              //                             child: Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text(
              //                                     'Value: ${SController.outputDataFrom.value.toString()}'),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                         SizedBox(
              //                           height: 1.5.h,
              //                         ),
              //                         Divider(
              //                             thickness: 2,
              //                             color: Color.fromARGB(255, 241, 195, 86)),
              //                         SizedBox(height: 0.5.h),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Textfile(
              //                                 text: 'To',
              //                                 textsize: 18.sp,
              //                                 textweight: FontWeight.bold),
              //                             Container(
              //                               width: 100,
              //                               height: 40,
              //                               decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(8),
              //                                 color: Colors.grey,
              //                               ),
              //                               padding:
              //                                   const EdgeInsets.only(left: 20),
              //                               margin: const EdgeInsets.symmetric(
              //                                   vertical: 16),
              //                               child: DropdownButton<String>(
              //                                 menuMaxHeight: 30.h,
              //                                 value: selectedValueto,
              //                                 elevation: 2,
              //                                 isExpanded: true,
              //                                 items: SController.uniqueList
              //                                     .map((String item) {
              //                                   return DropdownMenuItem<String>(
              //                                     value: item,
              //                                     child: Text(
              //                                       item,
              //                                       style: TextStyle(
              //                                         fontSize: 14,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: isLightMode
              //                                             ? Colors.black
              //                                             : Colors.white,
              //                                       ),
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                     ),
              //                                   );
              //                                 }).toList(),
              //                                 onChanged: (String? value) async {
              //                                   setState(() {
              //                                     selectedValueto = value!;
              //                                   });
              //                                   //onexecfrom(await value);
              //                                   print(value);
              //                                   SController.isLoading.value =
              //                                       await false;
              //                                   print(await SController
              //                                       .isLoading.value);
              //                                   SController.clearOutputDataTo();
              //                                   SController
              //                                       .clearOutputDataFrom();
              //                                   SController.clearOutputDataTo();
              //                                   IDController.setValuein(0.0);
              //                                   IDController.setValueout(0.0);
              //                                   _textEditingController2.clear();
              //                                 },
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 1.5.h,
              //                         ),
              //                         Row(
              //                           children: [
              //                             SizedBox(
              //                               width: 45.w,
              //                               height: 10.h,
              //                               child: TextField(
              //                                 onTap: () async {
              //                                   print('fsdf');
              //                                   print(IDController
              //                                       .Outcounter.value);
              //                                   if (IDController
              //                                               .Outcounter.value ==
              //                                           0 &&
              //                                       SController
              //                                               .isLoading.value ==
              //                                           true) {
              //                                     print('111111');
              //                                     SController.isLoading.value =
              //                                         await false;
              //                                     print(await SController
              //                                         .isLoading.value);
              //                                     SController
              //                                         .clearOutputDataFrom();
              //                                     SController
              //                                         .clearOutputDataTo();
              //                                     IDController.setValuein(0.0);
              //                                     IDController.setValueout(0.0);
              //                                     _textEditingController1
              //                                         .clear();
              //                                   }
              //                                 },
              //                                 onChanged: (value) async {
              //                                   IDController.setValueout(
              //                                       double.parse(value));
              //                                   var a = await SController
              //                                       .tokenCoin
              //                                       .indexOf(selectedValuefrom);
              //                                   var b = await SController
              //                                       .tokenCoin
              //                                       .indexOf(selectedValueto);
              //                                   print(value);
              //                                   if (SController
              //                                               .isLoading.value ==
              //                                           false &&
              //                                       selectedValuefrom != null &&
              //                                       selectedValueto != null) {
              //                                     print(SController.rpccoin[b]
              //                                         .toString());
              //                                     print(
              //                                       SController.tokenAddress[b]
              //                                           .toString(),
              //                                     );
              //                                     print(SController
              //                                         .tokenAddress[a]
              //                                         .toString());
              //                                     print(value.toString());
              //                                     SController.fetchDatafrom(
              //                                         SController.rpccoin[b]
              //                                             .toString(),
              //                                         SController
              //                                             .tokenAddress[b]
              //                                             .toString(),
              //                                         SController
              //                                             .tokenAddress[a]
              //                                             .toString(),
              //                                         value.toString());

              //                                     SController.isLoading.value =
              //                                         true;
              //                                     _textEditingController1.text =
              //                                         SController
              //                                             .outputDataFrom.value
              //                                             .toString();
              //                                   } else if (SController
              //                                           .isLoading ==
              //                                       true) {
              //                                     print(value);
              //                                     SController.multiplefrom(
              //                                         double.parse(value));
              //                                   }
              //                                   //  else if (IDController
              //                                   //         .Outcounter ==
              //                                   //     0.0) {
              //                                   //   SController.isLoading == false;
              //                                   //   SController
              //                                   //       .clearOutputDataFrom();
              //                                   // }
              //                                 },
              //                                 keyboardType:
              //                                     TextInputType.number,
              //                                 controller:
              //                                     _textEditingController2,
              //                                 decoration: InputDecoration(
              //                                   hintText: 'Enter Amount',
              //                                 ),
              //                               ),
              //                             ),
              //                             Column(
              //                               children: [
              //                                 IconButton(
              //                                     iconSize: 15,
              //                                     icon: Icon(Icons.add),
              //                                     onPressed: () async {
              //                                       IDController.incrementout();
              //                                       _textEditingController2
              //                                               .text =
              //                                           await IDController
              //                                                   .Outcounter
              //                                               .toString();
              //                                     }),
              //                                 IconButton(
              //                                     iconSize: 15,
              //                                     icon: Icon(Icons.remove),
              //                                     onPressed: () async {
              //                                       IDController.decrementout();
              //                                       _textEditingController2
              //                                               .text =
              //                                           await IDController
              //                                                   .Outcounter
              //                                               .toString();
              //                                     }),
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                         Obx(
              //                           () => Padding(
              //                             padding:
              //                                 const EdgeInsets.only(left: 8.0),
              //                             child: Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text(
              //                                     'Value: ${SController.outputDataTo.value.toString()}'),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                         SizedBox(
              //                           height: 0.4.h,
              //                         ),
              //                         RoundedButton(
              //                             buttontext: 'Swap',
              //                             buttoncolor: Color.fromARGB(255, 241, 195, 86),
              //                             Textcolor: isLightMode
              //                                 ? Colors.black
              //                                 : Colors.white,
              //                             weightfont: FontWeight.normal,
              //                             Pressed: () async {
              //                               // SController.fetchData(
              //                               //     'https://bsc.publicnode.com',
              //                               //     '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
              //                               //     '0x9767c8E438Aa18f550208e6d1fDf5f43541cC2c8',
              //                               //     '1');
              //                               var sym = [
              //                                 'BNB',
              //                                 'ETH',
              //                                 'MATIC',
              //                                 'AVAX'
              //                               ];
              //                               // print(selectedValuefrom);
              //                               // print(selectedValueto);
              //                               print(SController
              //                                   .outputDataFrom.value);
              //                               print(
              //                                   SController.outputDataTo.value);
              //                               var a = await SController.tokenCoin
              //                                   .indexOf(selectedValuefrom);
              //                               var b = await SController.tokenCoin
              //                                   .indexOf(selectedValueto);
              //                               print(SController.rpccoin[a]);
              //                               print(SController.rpccoin[b]);
              //                               print(SController.tokenAddress[a]);
              //                               print(SController.tokenAddress[b]);
              //                               if (sym.contains(
              //                                       selectedValuefrom) &&
              //                                   sym.contains(selectedValueto)) {
              //                                 Get.snackbar('Error',
              //                                     'Network coin can`t be swap');
              //                               }
              //                               if (await SController.rpccoin[a]
              //                                       .toString() !=
              //                                   await SController.rpccoin[b]
              //                                       .toString()) {
              //                                 //  print(SController.rpccoin[a]
              //                                 //     .toString());
              //                                 // print(SController.rpccoin[b]
              //                                 //     .toString());
              //                                 Get.snackbar('Error',
              //                                     'Different network asset can`t be swap');
              //                               } else if (SController.rpccoin[a] ==
              //                                       SController.rpccoin[b] &&
              //                                   !sym.contains(
              //                                       selectedValuefrom) &&
              //                                   !sym.contains(
              //                                       selectedValueto)) {
              //                                 // Get.snackbar(
              //                                 //     'success', 'continue');
              //                                 //swap token code for two token of same network here no network can be used
              //                                 await SController.swapToken(
              //                                     await widget.pkey,
              //                                     await SController
              //                                         .outputDataFrom.value
              //                                         .toString(),
              //                                     // await double.parse(
              //                                     //     selectedcurrfrom
              //                                     //         .toString()),
              //                                     await SController
              //                                         .tokenAddress[a],
              //                                     await SController
              //                                         .tokenAddress[b]);
              //                               } else if (SController.rpccoin[a] ==
              //                                       SController.rpccoin[b] &&
              //                                   sym.contains(
              //                                       selectedValuefrom) &&
              //                                   !sym.contains(
              //                                       selectedValueto)) {
              //                                 //  Get.snackbar('ok', 'nton');
              //                                 SController.nonNativeToNative(
              //                                     widget.pkey,
              //                                     SController
              //                                         .outputDataFrom.value
              //                                         .toString(),
              //                                     SController.rpccoin[a],
              //                                     SController.tokenAddress[b]);
              //                               }
              //                             },
              //                             fontsize: 15.sp)
              //                       ],
              //                     )));
              //           }),
              //           actions: [],
              //         ));

              Get.to(
                swapscreen(
                  pkey: widget.pkey,
                  from: widget.from,
                  bal: widget.bal,
                  rpc: widget.rpc,
                ),
                transition: Transition.native,
                duration: Duration(milliseconds: 700),
              );
              //getTokenPrice('5');
            },
            icon: Icon(
              Icons.swap_horizontal_circle_outlined,
              color: Colors.grey,
              size: 35,
            )),
        Textfile(
            text: "Swap",
            textcolor: isLightMode ? Colors.black : Colors.white,
            textsize: 15.sp,
            textweight: FontWeight.bold),
      ],
    );
  }
}
