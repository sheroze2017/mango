import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/multiwallet__controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Controller/accountimport_Controller.dart';

class Dailog_multiwallet extends StatelessWidget {
  // final String private_key;

  // Dailog_multiwallet({required this.private_key});

  TextEditingController _password = TextEditingController(text: "");

  final _storage = FlutterSecureStorage();
  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    final multiwallet controller = Get.put(multiwallet());
    final controllerimp = Get.put(importAccount());
    String phrases = '';

    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () async {
        print('sas');

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor:
                      isLightMode ? Color(0xffF5FAFA) : Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color.fromARGB(255, 241, 195, 86)
                          //  isLightMode
                          //  ? Color.fromARGB(255, 241, 195, 86)
                          //  : Color(0xffFFB800)

                          )),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            print(controller.dataadd);
                            print(controller.datakey);
                          },
                          child: Text(
                            'Wallets',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 33.h,
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.dataadd.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.wallet,
                                    color: Color.fromARGB(255, 241, 195, 86),
                                  ),
                                  title: GestureDetector(
                                    onTap: () {
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
                                                        255, 241, 195, 86))),
                                            title: Text('Confirm'),
                                            content: Text(
                                                'Continue to change your wallet?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  print(controller
                                                      .datakey[index]);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 241, 195, 86)),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // controllerimp
                                                  //         .isLoading.value ==
                                                  //     true;
                                                  await controllerimp
                                                      .isLoading(true);
                                                  // print(controller
                                                  //     .dataadd[index]);
                                                  // print(controller
                                                  //     .datakey[index]);
                                                  // print(controller
                                                  //     .datakey[index]
                                                  //     .toString());
                                                  // String pk = await getdata(
                                                  //     controller.datakey[index]
                                                  //         .toString());
                                                  // print(pk);

                                                  var response = await http.get(
                                                    Uri.parse(
                                                        'https://sbgwallet.io:9000/api/decrypt?input=' +
                                                            controller
                                                                .datakey[index]
                                                                .toString()),
                                                  );
                                                  print(response.body);
                                                  var decodedResponse =
                                                      await jsonDecode(
                                                          response.body);
                                                  String privateKey =
                                                      await decodedResponse[
                                                              'privateKey']
                                                          ['privateKey'];
                                                  print(privateKey);

                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                      () async =>
                                                          await controllerimp
                                                              .fetch(
                                                                  privateKey));

                                                  //   final response =
                                                  //       await http.get(Uri.parse(
                                                  //           'https://sbgwallet.io:9000/api/decrypt?input=' +
                                                  //               controller
                                                  //                   .datakey[
                                                  //                       index]
                                                  //                   .toString()));
                                                  //   final decodedResponse =
                                                  //       jsonDecode(response.body);
                                                  //   final privateKey =
                                                  //       decodedResponse[
                                                  //               'privateKey']
                                                  //           ['privateKey'];
                                                  //   print('hihihihihihihi');
                                                  //   print(privateKey);
                                                  //   print('hihihihihihihi');
                                                  //   Future.delayed(
                                                  //           const Duration(
                                                  //               seconds: 2),
                                                  //           () => controllerimp.fetch(
                                                  //                 controller
                                                  //                     .datakey[
                                                  //                         index]
                                                  //                     .text,
                                                  //               ))
                                                  //       .then((value) =>
                                                  //           Navigator.pushNamedAndRemoveUntil(
                                                  //               context,
                                                  //               '/home',
                                                  //               arguments: [
                                                  //                 phrases,
                                                  //                 controller
                                                  //                         .dataadd[
                                                  //                     index],
                                                  //                 controller
                                                  //                         .datakey[
                                                  //                     index]
                                                  //               ],
                                                  //               (Route<dynamic> route) =>
                                                  //                   false))
                                                  //       .onError((error,
                                                  //               stackTrace) =>
                                                  //           Get.snackbar('Error',
                                                  //               'No Account Exist',
                                                  //               duration: Duration(
                                                  //                   seconds: 2),
                                                  //               backgroundColor:
                                                  //                   Colors.white,
                                                  //               colorText: Colors
                                                  //                   .black));

                                                  //   print('password match');
                                                },
                                                child: Obx(() {
                                                  if (controllerimp
                                                      .isLoading.value) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      241,
                                                                      195,
                                                                      86)),
                                                    );
                                                  } else {
                                                    return Text('OK',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    195,
                                                                    86)));
                                                  }
                                                }),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                        height: 1.5.h,
                                        width: 22.w,
                                        child: Text(
                                          controller.dataadd[index],
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              color: isLightMode
                                                  ? Colors.black
                                                  : Colors.white),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // actions: [
                  //   Container(
                  //     height: 28.h,
                  //     width: 95.w,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Textfile(
                  //             text: "Wallets",
                  //             textcolor:
                  //                 isLightMode ? Colors.black : Colors.white,
                  //             textsize: 18.sp,
                  //             textweight: FontWeight.bold),
                  //       ],
                  //     ),
                  //   ),
                  // ],
                ));
      },
      child: Container(
        height: 5.h,
        width: 73.w,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 241, 195, 86),
              //  isLightMode
              // ? Color.fromARGB(255, 241, 195, 86)
              // : Color(0xffFFB800)
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(padding / 60),
          child: Row(
            children: [
              Icon(
                Icons.wallet,
                color: isLightMode ? Colors.black : Colors.white,
                size: 16,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                "Your Wallets",
                style: TextStyle(
                    color: isLightMode ? Colors.black : Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
