import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Components/Richtextfile.dart';
import '../Components/Textfile.dart';

class Dialog_term_of_use extends StatelessWidget {
  const Dialog_term_of_use({super.key});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Richtextfile(
        text1: "I have read and agree to the",
        text2: "Terms of use",
        click: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Color.fromARGB(255, 241, 195, 86))),
                    backgroundColor: Color(0xffF5FAFA),
                    actions: [
                      Container(
                        height: 70.h,
                        width: 95.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                isLightMode ? Color(0xffF5FAFA) : Colors.white),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: padding / 5),
                                  child: Textfile(
                                      text: "Terms of use",
                                      textcolor: Colors.black,
                                      textsize: 18.sp,
                                      textweight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.cancel,
                                        color:
                                            Color.fromARGB(255, 241, 195, 86))),
                              ],
                            ),

                            Divider(
                                thickness: 2,
                                color: Color.fromARGB(255, 241, 195, 86)),
                            Padding(
                              padding: EdgeInsets.all(padding / 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textfile(
                                      text: "Lorem Ipsum is simply dummy text",
                                      textcolor: Colors.black,
                                      textsize: 14.sp,
                                      textweight: FontWeight.bold),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text:
                                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text:
                                          "Contrary to popular belief, Lorem Ipsum is not simply random text",
                                      textcolor: Colors.black,
                                      textsize: 14.sp,
                                      textweight: FontWeight.bold),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Textfile(
                                      text: "Lorem Ipsum is simply dummy text.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  Textfile(
                                      text: "Lorem Ipsum is simply dummy text.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  Textfile(
                                      text: "Lorem Ipsum is simply dummy text.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  Textfile(
                                      text:
                                          "Lorem Ipsum has been the industry's standard dummy.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text: "It was popularised in the 1960s.",
                                      textcolor: Colors.black,
                                      textsize: 14.sp,
                                      textweight: FontWeight.bold),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Textfile(
                                      text:
                                          "It has roots in a piece of classical Latin literature!",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  Textfile(
                                      text:
                                          "If someone asks for your recovery phrase they are likely trying to scam you and steal your wallet funds.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text: "Lorem Ipsum is simply dummy text",
                                      textcolor: Colors.black,
                                      textsize: 14.sp,
                                      textweight: FontWeight.bold),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text:
                                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Textfile(
                                      text: "It was popularised in the 1960s.",
                                      textcolor: Colors.black,
                                      textsize: 14.sp,
                                      textweight: FontWeight.bold),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Textfile(
                                      text:
                                          "It has roots in a piece of classical Latin literature!",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Textfile(
                                      text:
                                          "It has roots in a piece of classical Latin literature!",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                  Textfile(
                                      text:
                                          "If someone asks for your recovery phrase they are likely trying to scam you and steal your wallet funds.",
                                      textcolor: Colors.black,
                                      textsize: 12.sp,
                                      textweight: FontWeight.normal),
                                ],
                              ),
                            ),
                            //  Padding(
                            //    padding:  EdgeInsets.all(20),
                            //    child: Row(
                            //     children: [
                            //     Textfile(
                            //     text: "coinbase",
                            //     textcolor: Color.fromARGB(255, 241, 195, 86)
                            //     textsize: 14.sp,
                            //     textweight: FontWeight.normal),
                            //     SizedBox(
                            //       width: 8.w,
                            //     ),
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Textfile(
                            //         text: "Deposit ETH with coinbase",
                            //         textcolor: Colors.black,
                            //         textsize: 12.sp,
                            //         textweight: FontWeight.bold),

                            //         SizedBox(
                            //           height: 4.h,
                            //           width: 45.w,
                            //           child: Textfile(
                            //           text: "To interact with decentralized applications using Mango Wallet ",
                            //           textcolor: Colors.black,
                            //           textsize: 11.sp,
                            //           textweight: FontWeight.normal),
                            //         ),

                            //       ],
                            //     ),
                            //     ],
                            //    ),
                            //  ),
                          ],
                        ),
                      ),
                    ],
                  ));
        },
        text1color: isLightMode ? Colors.black : Colors.white,
        text2color: Color.fromARGB(255, 241, 195, 86),
        text1size: 14.sp,
        text1weight: FontWeight.normal,
        text2size: 14.sp,
        text2weight: FontWeight.normal,
        text1space: 1,
        text2space: 1);
  }
}
