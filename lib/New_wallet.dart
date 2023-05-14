import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'package:sbgwallet/Components/RoundedButton.dart';
import 'package:sbgwallet/Recovery_Phrase.dart';

import 'CreatePassword.dart';
import 'Switch_button.dart';

class New_wallet extends StatelessWidget {
  const New_wallet({super.key});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: padding / 12,
            left: padding / 20,
            right: padding / 20,
            bottom: padding / 20),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "Assets/finallogo.png",
                        scale: 3,
                      ),
                      Switch_button(),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Textfile(
                    text: "New to Mango Wallet?",
                    textcolor: isLightMode ? Colors.black : Colors.white,
                    textsize: 22.sp,
                    textweight: FontWeight.bold,
                  ).animate(delay: 1000.ms).scaleX(),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: padding / 20,
                        right: padding / 20,
                        bottom: padding / 20),
                    child: Container(
                      height: 35.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 241, 195, 86),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: padding / 20,
                            right: padding / 20,
                            bottom: padding / 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.2.h,
                            ),
                            Icon(
                              Icons.download,
                              size: 50,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Textfile(
                                text: "No, I already have a ",
                                textcolor: Colors.black,
                                textsize: 17.sp,
                                textweight: FontWeight.bold),
                            Textfile(
                                text: "Secret Recovery Phrase",
                                textcolor: Colors.black,
                                textsize: 17.sp,
                                textweight: FontWeight.bold),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Textfile(
                                text: "Import your existing wallet",
                                textcolor: Colors.black,
                                textsize: 16.sp,
                                textweight: FontWeight.normal),
                            Textfile(
                                text: "using secret recovery phrase",
                                textcolor: Colors.black,
                                textsize: 16.sp,
                                textweight: FontWeight.normal),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              height: 5.5.h,
                              width: 50.w,
                              child: RoundedButton(
                                buttontext: "Import wallet",
                                buttoncolor: Colors.white,
                                Textcolor: Colors.black,
                                weightfont: FontWeight.normal,
                                Pressed: () {
                                  Get.to(() => Recovery_Phrase());
                                },
                                fontsize: 15.sp,
                              ).animate(delay: 800.ms).scaleX(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: padding / 20,
                        right: padding / 20,
                        bottom: padding / 20),
                    child: Container(
                      height: 35.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 241, 195, 86),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: padding / 40,
                            right: padding / 40,
                            bottom: padding / 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Textfile(
                                text: "Yes, Let’s get set up!",
                                textcolor: Colors.black,
                                textsize: 17.sp,
                                textweight: FontWeight.bold),
                            Textfile(
                                text: "This will create a new wallet and",
                                textcolor: Colors.black,
                                textsize: 16.sp,
                                textweight: FontWeight.normal),
                            Textfile(
                                text: "Secret Recovery Phrase",
                                textcolor: Colors.black,
                                textsize: 16.sp,
                                textweight: FontWeight.normal),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                                height: 5.5.h,
                                width: 50.w,
                                child: RoundedButton(
                                  buttontext: "Create wallet",
                                  buttoncolor: Colors.white,
                                  Textcolor: Colors.black,
                                  weightfont: FontWeight.normal,
                                  Pressed: () {
                                    Get.to(() => CreatePassword());
                                  },
                                  fontsize: 15.sp,
                                ).animate(delay: 800.ms).scaleX()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
