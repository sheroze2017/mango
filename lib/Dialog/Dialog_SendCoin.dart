import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/sendcoin_Controller.dart';

import '../Components/Textfile.dart';
import '../Components/sfslider.dart';

class Dialog_SendCoin extends StatefulWidget {
  final String pkey;

  final String from;

  final String bal;

  final String rpc;
  final String address;

  Dialog_SendCoin(
      {required this.pkey,
      required this.from,
      required this.bal,
      required this.rpc,
      required this.address});

  @override
  State<Dialog_SendCoin> createState() => _Dialog_SendCoinState();
}

class _Dialog_SendCoinState extends State<Dialog_SendCoin> {
  @override
//   State<Dialog_SendCoin> createState() => _Dialog_SendCoinState();
// }

// class _Dialog_SendCoinState extends State<Dialog_SendCoin> {

  TextEditingController recieveAddress = TextEditingController(text: "");

  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    sendC sendcoin_Controller = Get.put(sendC());
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    RangeValues _values = RangeValues(0, 100);

    return Column(
      children: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color.fromARGB(255, 241, 195, 86)
                                //  isLightMode
                                //  ? Color.fromARGB(255, 241, 195, 86)
                                //  : Color(0xffFFB800)
                                )),
                        backgroundColor:
                            isLightMode ? Color(0xffF5FAFA) : Colors.black,
                        actions: [
                          Container(
                              height: 40.h,
                              width: 95.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: padding / 40),
                                        child: Textfile(
                                            text: "Send to",
                                            textcolor: isLightMode
                                                ? Colors.black
                                                : Colors.white,
                                            textsize: 15.sp,
                                            textweight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            // print('ok');
                                            print(widget.pkey);
                                            // print('ok');
                                            print(widget.from);
                                            print(amount);
                                            print(widget.rpc);
                                            amount.clear();
                                            recieveAddress.clear();
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.cancel,
                                              color: Color.fromARGB(
                                                  255, 241, 195, 86)
                                              // isLightMode
                                              // ? Color.fromARGB(255, 241, 195, 86)
                                              // : Color(0xffFFB800)
                                              )),
                                    ],
                                  ),
                                  Divider(
                                      thickness: 2,
                                      color: Color.fromARGB(255, 241, 195, 86)
                                      //  isLightMode
                                      //   ? Color.fromARGB(255, 241, 195, 86)
                                      //   : Color(0xffFFB800)
                                      ),
                                  SizedBox(height: 0.9.h),
                                  SizedBox(
                                    height: 6.h,
                                    child: TextFormField(
                                      controller: recieveAddress,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          hintText: "Receive Address",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp),
                                          fillColor:
                                              Color.fromARGB(255, 241, 195, 86),
                                          //  isLightMode
                                          //  ? Color.fromARGB(255, 241, 195, 86)
                                          //  : Color(0xffFFB800),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86)
                                                  //   isLightMode
                                                  //  ? Color.fromARGB(255, 241, 195, 86)
                                                  //  : Color(0xffFFB800)
                                                  ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86)
                                                  // isLightMode
                                                  // ? Color.fromARGB(255, 241, 195, 86)
                                                  // : Color(0xffFFB800)
                                                  ))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                    child: TextFormField(
                                      controller: amount,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.send,
                                                size: 15,
                                                color: isLightMode
                                                    ? Color(0xffF5FAFA)
                                                    : Colors.white),
                                            onPressed: () async {
                                              if ((recieveAddress.text
                                                              .toString()
                                                              .length <
                                                          40 ||
                                                      recieveAddress.text
                                                              .toString()
                                                              .length >
                                                          42) ||
                                                  amount.text == '') {
                                                Get.snackbar('Error',
                                                    'Incorrect Input Field',
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.white,
                                                    colorText: Colors.black);
                                              }
                                              // print(_key);
                                              // print(_address);
                                              // print(recieveAddress);
                                              // print(amount.text);
                                              // print(_rpc);
                                              else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          backgroundColor:
                                                              isLightMode
                                                                  ? Color(
                                                                      0xffF5FAFA)
                                                                  : Colors
                                                                      .black,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  side: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          241,
                                                                          195,
                                                                          86)
                                                                      //    isLightMode
                                                                      // ? Color.fromARGB(255, 241, 195, 86)
                                                                      // : Color(0xffFFB800)

                                                                      )),
                                                          title: const Text(
                                                              'Confirm Transfer'),
                                                          content: const Text(
                                                              'Are you sure you want to proceed with Transfer?'),
                                                          actions: [
                                                            Container(
                                                                child: Obx(
                                                              () {
                                                                if (sendcoin_Controller
                                                                    .isLoading
                                                                    .value) {
                                                                  return Center(
                                                                      child: CircularProgressIndicator(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              241,
                                                                              195,
                                                                              86)));
                                                                } else {
                                                                  return Column(
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                        child:
                                                                            const Text(
                                                                          'CANCEL',
                                                                          style:
                                                                              TextStyle(color: Color.fromARGB(255, 241, 195, 86)),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (recieveAddress.text.toString().length <= 42 &&
                                                                              recieveAddress.text.toString().length >= 40) {
                                                                            sendcoin_Controller.isLoading.value =
                                                                                true;
                                                                            Future.delayed(Duration(seconds: 2));
                                                                            await sendcoin_Controller.sendc(
                                                                                await widget.pkey,
                                                                                await widget.address,
                                                                                await recieveAddress.text.toString(),
                                                                                await amount.text.toString(),
                                                                                await widget.rpc.toString());

                                                                            Navigator.pop(context);
                                                                            recieveAddress.clear();
                                                                            amount.clear();
                                                                          }
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'CONFIRM',
                                                                          style:
                                                                              TextStyle(color: Color.fromARGB(255, 241, 195, 86)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            ))
                                                          ]);
                                                    });
                                              } // if (recieveAddress.text
                                              //             .toString()
                                              //             .length <=
                                              //         42 &&
                                              //     recieveAddress.text
                                              //             .toString()
                                              //             .length >=
                                              //         40) {
                                              //   sendcoin_Controller
                                              //       .isLoading.value = true;
                                              //   Future.delayed(
                                              //       Duration(seconds: 2));
                                              //   await sendcoin_Controller
                                              //       .sendc(
                                              //           await pkey,
                                              //           await from,
                                              //           await recieveAddress
                                              //               .text
                                              //               .toString(),
                                              //           await amount.text
                                              //               .toString(),
                                              //           await rpc
                                              //               .toString());

                                              //   Navigator.pop(context);
                                              //   recieveAddress.clear();
                                              //   amount.clear();
                                              // }
                                            },
                                          ),
                                          hintText: "Amount",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp),
                                          fillColor:
                                              Color.fromARGB(255, 241, 195, 86),
                                          //   isLightMode
                                          //  ? Color.fromARGB(255, 241, 195, 86)
                                          //  : Color(0xffFFB800),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86)))),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 1.h,
                                  // ),
                                  Center(
                                    child: CustomSlider(
                                      initialValue: 0,
                                      onValueChanged: (value) {
                                        setState(() {
                                          amount.text =
                                              ((double.parse(widget.bal) /
                                                          100) *
                                                      value)
                                                  .toStringAsFixed(4);
                                          // Update the text field
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        String? qrCodeData =
                                            await Get.to(QRCodeScanner());
                                        // await Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder:
                                        //         (BuildContext context) =>
                                        //             QRCodeScanner(),
                                        //   ),
                                        // );

                                        // Update the text field with the scanned QR code data
                                        if (qrCodeData != null) {
                                          recieveAddress.text = qrCodeData;
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Textfile(
                                              text: "Scan QR Code",
                                              textcolor: isLightMode
                                                  ? Colors.black
                                                  : Colors.white,
                                              textsize: 16.sp,
                                              textweight: FontWeight.bold),
                                          Icon(Icons.qr_code)
                                        ],
                                      )),
                                  SizedBox(
                                    width: 15.w,
                                  )
                                ],
                              ))
                        ],
                      ));
            },
            //      icon: Icon(
            //       Icons.arrow_circle_down,
            //       color: Colors.grey,
            //       size: 35,
            //     )),
            // Center(
            //   child: Textfile(
            //       text: "Buy",
            //       textcolor: isLightMode ? Colors.black : Colors.white,
            //       textsize: 15.sp,
            //       textweight: FontWeight.normal),
            // ),
            icon: Icon(
              Icons.arrow_circle_right,
              color: Color.fromARGB(255, 241, 195, 86),
              size: 35,
            )),
        // icon: Icon(
        //   Icons.arrow_circle_right,
        //   size: 35,
        //  color: Color.fromARGB(255, 241, 195, 86),
        // ),
        //),
        Textfile(
            text: "Send",
            textcolor: isLightMode
                ? Color.fromARGB(255, 241, 195, 86)
                : Color.fromARGB(255, 241, 195, 86),
            textsize: 15.sp,
            textweight: FontWeight.bold),
      ],
    );
  }
}

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // QrImage(
          //   data: "1234567890",
          //   version: QrVersions.auto,
          //   size: 200.0,
          // ),
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (result!.format != null) {
                Get.back(result: result!.code);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: (result != null)
                      ? AlertDialog(
                          backgroundColor: Color(0xffF5FAFA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 241, 195, 86)
                                  //  isLightMode
                                  //  ? Color.fromARGB(255, 241, 195, 86)
                                  //  : Color(0xffFFB800)

                                  )),
                          title: Text('QR Scanned'),
                          content: Center(
                            child: Text(
                              'Address: ${result!.code}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 241, 195, 86),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Get.back(result: result!.code);

                                // Navigator.of(context).pop();
                              },
                              child: Text(
                                'Copy',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 241, 195, 86)),
                              ),
                            ),
                          ],
                        )
                      : Text('Scan a code'),
                )
              ],
            ),
          ),

          // Positioned(
          //   top: 40,
          //   right: 60,
          //   child: InkWell(
          //     onTap: () {
          //       Get.to(QRDialog(
          //           data: '0x9A2478C4036548864d96a97Fbf93f6a3341fedac'));

          //       // Navigator.pop(context);
          //     },
          //     child: Row(
          //       children: [
          //         Text('Generate QR'),
          //         Icon(Icons.qr_code_2),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  // void _onQRViewCreated(QRViewController qrViewController) async {
  //   setState(() {
  //     controller = qrViewController;
  //   });
  //    controller.scannedDataStream.listen((scanData) {
  //     // Extract the address from the QR code data
  //     String? address = scanData.code;
  //     // Pass the address back to the calling widget
  //     Get.back(result: address);
  //   });
  //   // Get.back(result: 'asdfg');
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
