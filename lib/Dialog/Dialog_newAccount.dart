//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Components/NormalOutlinebutton.dart';
import '../Components/RoundedButton.dart';
import '../Components/Textfile.dart';
import '../Controller/createnewAccount_Controller.dart';
import '../Controller/multiwallet__controller.dart';

// final List<dynamic> arguments = Get.arguments;
// final String private_key = arguments[2];
final _storage = FlutterSecureStorage();

TextEditingController _accountname = TextEditingController(text: "");

class Dialog_New_Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? data = '';
    String? phrases = '';
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final multiwallet controller = Get.put(multiwallet());

    final accountcontroller = Get.put(newAccountImport());

    final arg = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 241, 195, 86),
                //  isLightMode
                // ? Color.fromARGB(255, 241, 195, 86)
                // : Color(0xffFFB800)
              ),
              borderRadius: BorderRadius.circular(10)),
          height: 35.h,
          width: 95.w,
          child: Obx(() {
            if (accountcontroller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 241, 195, 86),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Textfile(
                      text: "Create Account",
                      textcolor: isLightMode ? Colors.black : Colors.white,
                      textsize: 22.sp,
                      textweight: FontWeight.bold),
                  Padding(
                    padding: EdgeInsets.only(
                        top: padding / 20,
                        left: padding / 20,
                        right: padding / 20),
                    child: SizedBox(
                      height: 5.h,
                      child: Text("Save previous Account private key"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 241, 195, 86),
                          //  isLightMode
                          // ? Color.fromARGB(255, 241, 195, 86)
                          // : Color(0xffFFB800)
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 10.h,
                      width: 75.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 6.h,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Account",
                                hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: isLightMode
                                        ? Colors.black
                                        : Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 241, 195, 86)
                                        //   isLightMode
                                        //  ? Color.fromARGB(255, 241, 195, 86)
                                        //  : Color(0xffFFB800),
                                        )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                        //   isLightMode
                                        //  ? Color.fromARGB(255, 241, 195, 86)
                                        //  : Color(0xffFFB800),
                                        width: 2))),
                          ),
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
                          buttontext: 'Back',
                          pressed: () {
                            Navigator.pop(context);
                          },
                          textcolor: Color.fromARGB(255, 241, 195, 86),
                          //  isLightMode
                          //  ? Color.fromARGB(255, 241, 195, 86)
                          //  : Color(0xffFFB800),
                          textsize: 14.sp,
                          textweight: FontWeight.normal,
                          buttoncolor: Color.fromARGB(255, 241, 195, 86),
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
                        child: Obx(
                          () {
                            if (accountcontroller.isLoading.value) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 241, 195, 86),
                              ));
                            } else {
                              return RoundedButton(
                                  buttontext: "Create",
                                  buttoncolor:
                                      Color.fromARGB(255, 241, 195, 86),
                                  //  isLightMode
                                  //  ? Color.fromARGB(255, 241, 195, 86)
                                  //  : Color(0xffFFB800),
                                  Textcolor: Colors.black,
                                  weightfont: FontWeight.normal,
                                  Pressed: () async {
                                    accountcontroller.fetch();
                                    // Future.delayed(
                                    //     const Duration(seconds: 2),
                                    //     () => Navigator.pushNamedAndRemoveUntil(
                                    //         context,
                                    //         '/home',
                                    //         arguments: [
                                    //           phrases,
                                    //           accountcontroller.data[1],
                                    //           accountcontroller.data[0]
                                    //         ],
                                    //         (Route<dynamic> route) => false));
                                    controller.loaddata();
                                  },
                                  fontsize: 14.sp);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
