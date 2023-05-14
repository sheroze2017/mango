import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/sendAmount_controller.dart';

import '../Components/Textfile.dart';
import '../Components/sfslider.dart';

class Dialog_Send extends StatefulWidget {
  final String balance;
  final String symbol;
  final String rpc;
  final String tokena;
  final String walleta;
  final String pkey;

  Dialog_Send({
    required this.balance,
    required this.symbol,
    required this.rpc,
    required this.tokena,
    required this.walleta,
    required this.pkey,
  });

  @override
  State<Dialog_Send> createState() => _Dialog_SendState();
}

class _Dialog_SendState extends State<Dialog_Send> {
  TextEditingController recieveAddress = TextEditingController(text: "");

  TextEditingController amount = TextEditingController();

  final TextEditingController qrCodeController = TextEditingController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late QRViewController controller;

  @override
  void dispose() {
    recieveAddress.dispose();
    amount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sendA sendamtcontroller = Get.put(sendA());

    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
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
                                // ?Color.fromARGB(255, 241, 195, 86)
                                // : Color(0xffFFB800)
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
                              child: Obx(
                                () {
                                  if (sendamtcontroller.isLoading.value) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: Color.fromARGB(
                                              255, 241, 195, 86)),
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: padding / 40),
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
                                                  // print(recieveAddress.text.toString());
                                                  // print(tokena);
                                                  // print(amount.text.toString());
                                                  // print(rpc);
                                                  // print(balance);
                                                  //dispose();
                                                  recieveAddress.clear();
                                                  amount.clear();
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
                                            color: Color.fromARGB(
                                                255, 241, 195, 86)
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
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                hintText: "Receive Address",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13.sp),
                                                fillColor: Color.fromARGB(
                                                    255, 241, 195, 86),
                                                //  isLightMode
                                                //  ? Color.fromARGB(255, 241, 195, 86)
                                                //  : Color(0xffFFB800),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    195,
                                                                    86)
                                                            //   isLightMode
                                                            //  ? Color.fromARGB(255, 241, 195, 86)
                                                            //  : Color(0xffFFB800)
                                                            ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(10)),
                                                        borderSide: BorderSide(color: Color.fromARGB(255, 241, 195, 86)
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
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
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
                                                      print(widget.pkey);
                                                      Get.snackbar('Error',
                                                          'Incorrect Input Field',
                                                          duration: Duration(
                                                              seconds: 2),
                                                          backgroundColor:
                                                              Colors.white,
                                                          colorText:
                                                              Colors.black);
                                                    }
                                                    //  print(balance);
                                                    // print(pkey);
                                                    // print(symbol);
                                                    // print(rpc);
                                                    // print(tokena)
                                                    // ;
                                                    else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  isLightMode
                                                                      ? Color(
                                                                          0xffF5FAFA)
                                                                      : Colors
                                                                          .black,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  side: BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          241,
                                                                          195,
                                                                          86))),
                                                              title: const Text(
                                                                  'Confirm Transfer'),
                                                              content: const Text(
                                                                  'Are you sure you want to proceed with Transfer?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                    'CANCEL',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            241,
                                                                            195,
                                                                            86)),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    final _storage =
                                                                        FlutterSecureStorage();

                                                                    if (recieveAddress.text.toString().length <=
                                                                            42 &&
                                                                        recieveAddress.text.toString().length >=
                                                                            40) {
                                                                      if (double.parse(widget
                                                                              .balance) >=
                                                                          double.parse(
                                                                              amount.text)) {
                                                                        // print(recieveAddress
                                                                        //     .text
                                                                        //     .toString());
                                                                        // print(pkey);
                                                                        // print(amount.text
                                                                        //     .toString());
                                                                        // print(tokena);
                                                                        // print(rpc);
                                                                        sendamtcontroller
                                                                            .isLoading
                                                                            .value = true;
                                                                        sendamtcontroller.sendtoken(
                                                                            await recieveAddress.text.toString(),
                                                                            await widget.pkey,
                                                                            await amount.text.toString(),
                                                                            await widget.tokena,
                                                                            await widget.rpc);
                                                                      } else {
                                                                        Get.snackbar(
                                                                            'Transaction Error',
                                                                            'Insufficient Funds',
                                                                            duration:
                                                                                Duration(seconds: 2),
                                                                            backgroundColor: Colors.white,
                                                                            colorText: Colors.black);
                                                                      }
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'CONFIRM',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            241,
                                                                            195,
                                                                            86)),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                    // final _storage =
                                                    //     FlutterSecureStorage();

                                                    // if (recieveAddress.text
                                                    //             .toString()
                                                    //             .length <=
                                                    //         42 &&
                                                    //     recieveAddress.text
                                                    //             .toString()
                                                    //             .length >=
                                                    //         40) {
                                                    //   if (double.parse(
                                                    //           balance) >=
                                                    //       double.parse(
                                                    //           amount.text)) {
                                                    //     // print(recieveAddress
                                                    //     //     .text
                                                    //     //     .toString());
                                                    //     // print(pkey);
                                                    //     // print(amount.text
                                                    //     //     .toString());
                                                    //     // print(tokena);
                                                    //     // print(rpc);
                                                    //     sendamtcontroller
                                                    //         .isLoading
                                                    //         .value = true;
                                                    //     sendamtcontroller.sendtoken(
                                                    //         await recieveAddress
                                                    //             .text
                                                    //             .toString(),
                                                    //         await pkey,
                                                    //         await amount.text
                                                    //             .toString(),
                                                    //         await tokena,
                                                    //         await rpc);
                                                    //   } else {
                                                    //     Get.snackbar(
                                                    //         'Transaction Error',
                                                    //         'Insufficient Funds',
                                                    //         duration: Duration(
                                                    //             seconds: 2),
                                                    //         backgroundColor:
                                                    //             Colors.white,
                                                    //         colorText:
                                                    //             Colors.black);
                                                    //   }
                                                    // }
                                                  },
                                                ),
                                                hintText: "Amount",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13.sp),
                                                fillColor: Color.fromARGB(
                                                    255, 241, 195, 86),
                                                //   isLightMode
                                                //  ? Color.fromARGB(255, 241, 195, 86)
                                                //  : Color(0xffFFB800),
                                                filled: true,
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 241, 195, 86)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(255, 241, 195, 86)))),
                                          ),
                                        ),
                                        Center(
                                          child: CustomSlider(
                                            initialValue: 0,
                                            onValueChanged: (value) {
                                              setState(() {
                                                amount.text = ((double.parse(
                                                                widget
                                                                    .balance) /
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
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          QRCodeScanner(),
                                                ),
                                              );

                                              // Update the text field with the scanned QR code data
                                              if (qrCodeData != null) {
                                                recieveAddress.text =
                                                    qrCodeData;
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
                                                    textweight:
                                                        FontWeight.bold),
                                                Icon(Icons.qr_code)
                                              ],
                                            )),
                                        SizedBox(
                                          width: 15.w,
                                        )
                                      ],
                                    );
                                  }
                                },
                              )),
                          // Textfile(
                          //     text: 'qrcode scan',
                          //     textsize: 12,
                          //     textweight: FontWeight.bold)
                        ],
                      ));
            },
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
        Center(
          child: Textfile(
              text: "Send",
              textcolor: isLightMode ? Colors.black : Colors.white,
              textsize: 15.sp,
              textweight: FontWeight.normal),
        ),
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
