import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/accountimport_Controller.dart';
import '../Components/NormalOutlinebutton.dart';
import '../Components/Richtextfile.dart';
import '../Components/Textfile.dart';
import '../Components/RoundedButton.dart';

class Dialog_Import_account extends StatelessWidget {
  late final String private_key;
  final _storage = FlutterSecureStorage();
  TextEditingController controllerPrivate = TextEditingController(text: "");

  Dialog_Import_account({required this.private_key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(importAccount());

    var padding = MediaQuery.of(context).size.width;
    String phrases = '';
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () async {
        var key = await _storage.read(key: 'encryptPK');
        print(private_key);
        print(key.toString());
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor:
                      isLightMode ? Color(0xffF5FAFA) : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color.fromARGB(255, 241, 195, 86),
                      //   isLightMode
                      //  ? Color.fromARGB(255, 241, 195, 86)
                      //  : Color(0xffFFB800)
                    ),
                  ),
                  actions: [
                    Container(
                        height: 40.h,
                        width: 80.w,
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 241, 195, 86)));
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Textfile(
                                    text: "Import Account",
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
                                      left: padding / 20, right: padding / 20),
                                  child: Richtextfile(
                                      text1:
                                          "Imported accounts will not be associated with your originally created Mango Wallet account Secret Recovery Phrase. Learn more about imported accounts",
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
                                  padding: EdgeInsets.all(padding / 20),
                                  child: SizedBox(
                                    // height: 6.h,
                                    child: SingleChildScrollView(
                                      child: TextFormField(
                                        maxLines: null,
                                        controller: controllerPrivate,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter Your Private Key String here",
                                            hintStyle: TextStyle(
                                                fontSize: 12.sp,
                                                color: isLightMode
                                                    ? Colors.black
                                                    : Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 241, 195, 86),
                                                  //  isLightMode
                                                  // ? Color.fromARGB(255, 241, 195, 86)
                                                  // : Color(0xffFFB800)
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 241, 195, 86),
                                                    //   isLightMode
                                                    // ? Color.fromARGB(255, 241, 195, 86)
                                                    // : Color(0xffFFB800),
                                                    width: 2))),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 4.5.h,
                                      width: 25.w,
                                      child: NormalOutlineButton(
                                        buttontext: 'Cancel',
                                        pressed: () async {
                                          Navigator.pop(context);
                                        },
                                        textcolor:
                                            Color.fromARGB(255, 241, 195, 86),
                                        // isLightMode
                                        //     ? Color.fromARGB(255, 241, 195, 86)
                                        //     : Color(0xffFFB800),
                                        textsize: 14.sp,
                                        textweight: FontWeight.normal,
                                        buttoncolor:
                                            Color.fromARGB(255, 241, 195, 86),
                                        // isLightMode
                                        // ? Color.fromARGB(255, 241, 195, 86)
                                        // : Color(0xffFFB800),
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
                                          buttoncolor:
                                              Color.fromARGB(255, 241, 195, 86),
                                          // isLightMode
                                          // ? Color.fromARGB(255, 241, 195, 86)
                                          // : Color(0xffFFB800),
                                          Textcolor: Colors.black,
                                          weightfont: FontWeight.normal,
                                          Pressed: () async {
                                            if (controllerPrivate.text.length ==
                                                    64 ||
                                                controllerPrivate.text.length ==
                                                    66) {
                                              controller.isLoading.value = true;

                                              Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                      () => controller.fetch(
                                                            controllerPrivate
                                                                .text,
                                                          ))
                                                  // .then((value) => Navigator
                                                  //     .pushNamedAndRemoveUntil(
                                                  //         context,
                                                  //         '/home',
                                                  //         arguments: [
                                                  //           phrases,
                                                  //           controller.data[1],
                                                  //           controller.data[0]
                                                  //         ],
                                                  //         (Route<dynamic>
                                                  //                 route) =>
                                                  //             false))
                                                  .onError((error,
                                                          stackTrace) =>
                                                      Get.snackbar('Error',
                                                          'No Account Exist',
                                                          duration: Duration(
                                                              seconds: 2),
                                                          backgroundColor:
                                                              Colors.white,
                                                          colorText:
                                                              Colors.black));

                                              print('password match');
                                            } else {
                                              print('not match');
                                            }
                                          },
                                          fontsize: 14.sp),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                        })),
                  ],
                ));
      },
      child: Container(
        height: 5.h,
        width: 73.w,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 241, 195, 86),
              //  isLightMode
              //  ? Color.fromARGB(255, 241, 195, 86)
              //  : Color(0xffFFB800)
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(padding / 60),
          child: Row(
            children: [
              Icon(
                Icons.download,
                color: isLightMode ? Colors.black : Colors.white,
                size: 16,
              ),
              SizedBox(
                width: 1.w,
              ),
              Textfile(
                  text: "Import Account",
                  textcolor: isLightMode ? Colors.black : Colors.white,
                  textsize: 13.5.sp,
                  textweight: FontWeight.normal),
            ],
          ),
        ),
      ),
    );
  }
}
