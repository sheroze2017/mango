import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Components/RoundedButton.dart';
import 'Components/Textfile.dart';
import 'Controller/swap_Controller.dart';

class swapscreen extends StatefulWidget {
  final String pkey;

  final String from;

  final String bal;

  final String rpc;

  swapscreen(
      {required this.pkey,
      required this.from,
      required this.bal,
      required this.rpc});
  @override
  State<swapscreen> createState() => _swapscreenState();
}

class _swapscreenState extends State<swapscreen> {
  TextEditingController recieveAddress = TextEditingController(text: "");

  swapController SController = Get.put(swapController());

  TextEditingController excfrom = TextEditingController();

  TextEditingController currfrom = TextEditingController();

  TextEditingController currto = TextEditingController();
  // CounterController IDController = Get.put(CounterController());

  TextEditingController excto = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  // void dispose() {
  //   _textEditingController1.dispose();
  //   _textEditingController2.dispose();
  //   excfrom.dispose();
  //   currfrom.dispose();
  //   currto.dispose();
  //   excto.dispose();
  // }

  String? selectedValuefrom;

  bool checkmate1 = false;
  bool checkmate2 = false;

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
    //   CounterController IDController = Get.put(CounterController());
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    // TextEditingController _textEditingController2 =
    //     TextEditingController(text: SController.outputDataTo.value.toString());

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: padding / 40),
                              child: Textfile(
                                  text: "Swap",
                                  textcolor:
                                      isLightMode ? Colors.black : Colors.white,
                                  textsize: 22.sp,
                                  textweight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: () async {
                                  // _textEditingController1.dispose();
                                  // _textEditingController2.dispose();
                                  SController.clearOutputDataFrom();
                                  SController.clearOutputDataTo();

                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel,
                                    color: Color.fromARGB(255, 241, 195, 86))),
                          ],
                        ),
                        Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 241, 195, 86)),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              //make border radius more than 50% of square height & width
                              child: Image.asset(
                                "Assets/icon.png",
                                height: 38.0,
                                width: 38.0,
                                fit: BoxFit.cover, //change image fill type
                              ),
                            ),
                            Container(
                              width: 20.w,
                              child: Textfile(
                                  text: 'From',
                                  textsize: 18.sp,
                                  textweight: FontWeight.bold),
                            ),
                            // Obx(
                            //   () =>
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.only(left: 20),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: DropdownButton<String>(
                                hint: Text('Select'),
                                menuMaxHeight: 30.h,
                                value: selectedValuefrom,
                                elevation: 2,
                                isExpanded: true,
                                items:
                                    SController.uniqueList.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) async {
                                  setState(() {
                                    selectedValuefrom = value!;
                                    if (selectedValueto != null) {
                                      checkmate1 = true;
                                      checkmate2 = true;
                                    }
                                  });
                                  //onexecfrom(await value);
                                  print(value);
                                  SController.isLoading.value = await false;
                                  print(await SController.isLoading.value);
                                  SController.clearOutputDataTo();
                                  SController.clearOutputDataFrom();
                                  SController.clearOutputDataTo();
                                  //      IDController.setValuein(0.0);
                                  //     IDController.setValueout(0.0);
                                  _textEditingController2.clear();
                                  _textEditingController1.clear();
                                },
                              ),
                            ),
                            //  ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 60.w,
                              height: 10.h,
                              child: TextField(
                                enabled: checkmate1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)([eE][+]?[0-9]+)?$')),
                                ],
                                onTap: () async {
                                  print(selectedValuefrom.toString() == '');
                                  print(selectedValueto);
                                  print('fff');
                                  // print('fsdf');
                                  // print(
                                  //     IDController.INcounter.value);
                                  if (SController.isLoading.value == false) {
                                    print('111111');
                                    SController.isLoading.value = await false;
                                    print(await SController.isLoading.value);
                                    SController.clearOutputDataTo();
                                    SController.clearOutputDataFrom();
                                    SController.clearOutputDataTo();

                                    //  IDController.setValuein(0.0);
                                    //  IDController.setValueout(0.0);
                                    _textEditingController2.clear();
                                    _textEditingController1.clear();
                                    print(SController.isLoading.value);
                                  }
                                },
                                onChanged: (value) async {
                                  SController.outputDataFrom.value =
                                      value.toString();
                                  //      IDController.setValuein(double.parse(value));
                                  print('ok');
                                  if (SController.isLoading.value == false &&
                                      selectedValuefrom != null &&
                                      selectedValueto != null) {
                                    String check = "1";
                                    var sym = ['BNB', 'ETH', 'MATIC', 'AVAX'];
                                    // print(selectedValuefrom);
                                    // print(selectedValueto);
                                    // print(selectedcurrto);
                                    // print(selectedcurrfrom);
                                    var a = await SController.tokenCoin
                                        .indexOf(selectedValuefrom);
                                    var b = await SController.tokenCoin
                                        .indexOf(selectedValueto);
                                    print(SController.rpccoin[a].toString());
                                    print(
                                        SController.tokenAddress[a].toString());
                                    print(
                                        SController.tokenAddress[b].toString());
                                    print(value.toString());
                                    SController.fetchData(
                                        SController.rpccoin[a].toString(),
                                        SController.tokenAddress[a].toString(),
                                        SController.tokenAddress[b].toString(),
                                        value.toString());
                                    //SController.isLoading.value = true;
                                  } else if (SController.isLoading.value ==
                                      true) {
                                    print(value);
                                    SController.multiple(double.parse(value));
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: _textEditingController1,
                                decoration: InputDecoration(
                                  hintText: 'Enter Amount',
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                // IconButton(
                                //     iconSize: 15,
                                //     icon: Icon(Icons.add),
                                //     onPressed: () async {
                                //       IDController.incrementin();
                                //       _textEditingController1.text =
                                //           await IDController.INcounter.toString();
                                //     }),
                                // IconButton(
                                //     iconSize: 15,
                                //     icon: Icon(Icons.remove),
                                //     onPressed: () async {
                                //       IDController.decrementin();
                                //       _textEditingController1.text =
                                //           await IDController.INcounter.toString();
                                //     }),
                              ],
                            ),
                          ],
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimate Deduct: ${SController.outputDataFrom.value.toString()}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Divider(
                            thickness: 2,
                            color: Color.fromARGB(255, 241, 195, 86)),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              //make border radius more than 50% of square height & width
                              child: Image.asset(
                                "Assets/icon.png",
                                height: 38.0,
                                width: 38.0,
                                fit: BoxFit.cover, //change image fill type
                              ),
                            ),
                            Container(
                              width: 20.w,
                              child: Textfile(
                                  text: 'To',
                                  textsize: 18.sp,
                                  textweight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   width: 10.w,
                            // ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.only(left: 20),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: DropdownButton<String>(
                                hint: Text('Select'),
                                menuMaxHeight: 30.h,
                                value: selectedValueto,
                                elevation: 2,
                                isExpanded: true,
                                items:
                                    SController.uniqueList.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) async {
                                  setState(() {
                                    selectedValueto = value!;
                                    if (selectedValuefrom != null) {
                                      checkmate1 = true;
                                      checkmate2 = true;
                                    }
                                  });
                                  //onexecfrom(await value);
                                  print(value);
                                  SController.isLoading.value = await false;
                                  print(await SController.isLoading.value);
                                  SController.clearOutputDataTo();
                                  SController.clearOutputDataFrom();
                                  SController.clearOutputDataTo();
                                  //    IDController.setValuein(0.0);
                                  //    IDController.setValueout(0.0);
                                  _textEditingController2.clear();
                                  _textEditingController1.clear();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 60.w,
                              height: 10.h,
                              child: TextField(
                                enabled: checkmate2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'^[+]?([0-9]+([.][0-9]*)?|[.][0-9]+)([eE][+]?[0-9]+)?$')),
                                ],
                                onTap: () async {
                                  //   print(IDController.Outcounter.value);
                                  if (SController.isLoading.value == false) {
                                    print('111111');
                                    SController.isLoading.value = await false;
                                    print(await SController.isLoading.value);
                                    SController.clearOutputDataFrom();
                                    SController.clearOutputDataTo();
                                    //     IDController.setValuein(0.0);
                                    //    IDController.setValueout(0.0);
                                    _textEditingController1.clear();
                                    _textEditingController2.clear();
                                  }
                                },
                                onChanged: (value) async {
                                  //   IDController.setValueout(double.parse(value));
                                  var a = await SController.tokenCoin
                                      .indexOf(selectedValuefrom);
                                  var b = await SController.tokenCoin
                                      .indexOf(selectedValueto);
                                  print(value);
                                  if (SController.isLoading.value == false &&
                                      selectedValuefrom != null &&
                                      selectedValueto != null) {
                                    // print(SController.rpccoin[b].toString());
                                    // print(
                                    //   SController.tokenAddress[b].toString(),
                                    // );
                                    // print(
                                    //     SController.tokenAddress[a].toString());
                                    // print(value.toString());
                                    await SController.fetchDatafrom(
                                        SController.rpccoin[b].toString(),
                                        SController.tokenAddress[b].toString(),
                                        SController.tokenAddress[a].toString(),
                                        value.toString());
                                    //  SController.isLoading.value = true;

                                    // _textEditingController1.text = SController
                                    //     .outputDataFrom.value
                                    //     .toString();
                                  } else if (SController.isLoading == true) {
                                    print(value);
                                    SController.multiplefrom(
                                        double.parse(value));
                                  }
                                  //  else if (IDController
                                  //         .Outcounter ==
                                  //     0.0) {
                                  //   SController.isLoading == false;
                                  //   SController
                                  //       .clearOutputDataFrom();
                                  // }
                                },
                                keyboardType: TextInputType.number,
                                controller: _textEditingController2,
                                decoration: InputDecoration(
                                  hintText: 'Enter Amount',
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                // IconButton(
                                //     iconSize: 15,
                                //     icon: Icon(Icons.add),
                                //     onPressed: () async {
                                //       IDController.incrementout();
                                //       _textEditingController2.text =
                                //           await IDController.Outcounter.toString();
                                //     }),
                                // IconButton(
                                //     iconSize: 15,
                                //     icon: Icon(Icons.remove),
                                //     onPressed: () async {
                                //       IDController.decrementout();
                                //       _textEditingController2.text =
                                //           await IDController.Outcounter.toString();
                                //     }),
                              ],
                            ),
                          ],
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Estimate Recieve: ${SController.outputDataTo.value.toString()}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          width: 25.w,
                          child: RoundedButton(
                              buttontext: 'Swap',
                              buttoncolor: Color.fromARGB(255, 241, 195, 86),
                              Textcolor:
                                  isLightMode ? Colors.black : Colors.white,
                              weightfont: FontWeight.normal,
                              Pressed: () async {
                                if (selectedValuefrom == null ||
                                    selectedValueto == null ||
                                    SController.outputDataFrom.value == '') {
                                  Get.snackbar('Error', 'Incorrect Input Field',
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.black);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: isLightMode
                                            ? Color(0xffF5FAFA)
                                            : Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                          ),
                                        ),
                                        title: const Text('Confirm Swap'),
                                        content: const Text(
                                            'Are you sure you want to proceed with Swap?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86)),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              SController.datafetch.value =
                                                  true;
                                              FocusScope.of(context).unfocus();
                                              //SController.isLoadingscreen.value = true;
                                              // SController.fetchData(
                                              //     'https://bsc.publicnode.com',
                                              //     '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
                                              //     '0x9767c8E438Aa18f550208e6d1fDf5f43541cC2c8',
                                              //     '1');
                                              var sym = [
                                                'BNB',
                                                'ETH',
                                                'MATIC',
                                                'AVAX'
                                              ];
                                              // print(selectedValuefrom);
                                              // print(selectedValueto);
                                              print('hi');
                                              print(SController
                                                  .outputDataFrom.value);
                                              print('hi');
                                              // print(SController.outputDataTo.value);
                                              var a = SController.tokenCoin
                                                  .indexOf(selectedValuefrom);
                                              var b = SController.tokenCoin
                                                  .indexOf(selectedValueto);
                                              var inrpc = SController.rpccoin[a]
                                                  .toString();
                                              var outrpc = SController
                                                  .rpccoin[b]
                                                  .toString();

                                              print(SController.rpccoin[a]);
                                              print(SController.rpccoin[b]);
                                              print(
                                                  SController.tokenAddress[a]);
                                              print(
                                                  SController.tokenAddress[b]);

                                              if (await inrpc.substring(
                                                      0, 20) !=
                                                  await outrpc.substring(
                                                      0, 20)) {
                                                Get.snackbar("Error",
                                                    "Different network token can't swap",
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.white,
                                                    colorText: Colors.black);
                                                print('hihihih');
                                                print(inrpc);
                                                print(outrpc);
                                                print('hihihih');
                                              } else if (await inrpc.substring(
                                                          0, 20) ==
                                                      await outrpc.substring(
                                                          0, 20) &&
                                                  !sym.contains(
                                                      selectedValuefrom) &&
                                                  !sym.contains(
                                                      selectedValueto)) {
                                                // Get.snackbar(
                                                //     'success', 'continue');
                                                //swap token code for two token of same network here no network can be used
                                                await SController.swapToken(
                                                    await widget.pkey,
                                                    await SController
                                                        .outputDataFrom.value
                                                        .toString(),
                                                    // await double.parse(
                                                    //     selectedcurrfrom
                                                    //         .toString()),
                                                    await SController
                                                        .tokenAddress[a],
                                                    await SController
                                                        .tokenAddress[b]);
                                              } else if (await inrpc.substring(
                                                          0, 20) ==
                                                      await outrpc.substring(
                                                          0, 20) &&
                                                  ((sym.contains(
                                                              selectedValuefrom) &&
                                                          !sym.contains(
                                                              selectedValueto)) ||
                                                      (!sym.contains(
                                                              selectedValuefrom) &&
                                                          sym.contains(
                                                              selectedValueto)))) {
                                                // Get.snackbar('ok', 'nton');
                                                print(widget.pkey);
                                                print(SController
                                                    .outputDataFrom.value
                                                    .toString());
                                                print(SController.rpccoin[a]);
                                                print(SController
                                                    .tokenAddress[b]);
                                                print(SController
                                                    .tokenAddress[a]);
                                                SController.nonNativeToNative(
                                                    widget.pkey,
                                                    SController
                                                        .outputDataFrom.value
                                                        .toString(),
                                                    SController.rpccoin[a],
                                                    SController.tokenAddress[b],
                                                    SController
                                                        .tokenAddress[a]);
                                              }
                                            },
                                            child: Obx(() {
                                              if (SController
                                                      .isLoadingscreen.value ==
                                                  true) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromARGB(
                                                        255, 241, 195, 86),
                                                  ),
                                                );
                                              } else
                                                return Text(
                                                  'Swap',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 241, 195, 86)),
                                                );
                                            }),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              fontsize: 15.sp),
                        )
                      ],
                    )))));
  }
}
