import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Components/Textfile.dart';
import 'Dialog_Import_account.dart';
import 'Dialog_Secret_Pass_match.dart';
import 'Dialog_create_account.dart';
import 'dailog_multiwallet.dart';

class Dialog_myaccount extends StatelessWidget {
  //const Dialog_myaccount({super.key});
  late final String private_key;
  late final String address;
  Dialog_myaccount({required this.private_key, required this.address});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side:
                            BorderSide(color: Color.fromARGB(255, 241, 195, 86)
                                //  isLightMode
                                //  ?Color.fromARGB(255, 241, 195, 86)
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

                          //  color: Color(0xffF5FAFA)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: padding / 40),
                                  child: Textfile(
                                      text: "My Account",
                                      textcolor: isLightMode
                                          ? Colors.black
                                          : Colors.white,
                                      textsize: 15.sp,
                                      textweight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Color.fromARGB(255, 241, 195, 86),
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
                                //   : Color(0xffFFB800),
                                ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Dialog_Create_Account(),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Dialog_Import_account(private_key: private_key),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Dialog_Secret_key(),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Dailog_multiwallet(),
                          ],
                        ),
                      ),
                    ],
                  ));
        },
        child: Icon(Icons.menu));
  }
}
