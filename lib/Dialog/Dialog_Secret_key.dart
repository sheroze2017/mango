import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Components/NormalOutlinebutton.dart';
import '../Components/Textfile.dart';
import '../Components/RoundedButton.dart';

class Dialog_Secret_key1 extends StatelessWidget {
  const Dialog_Secret_key1({super.key});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
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
                  actions: [
                    Container(
                      height: 28.h,
                      width: 95.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Textfile(
                              text: "Secret Key",
                              textcolor:
                                  isLightMode ? Colors.black : Colors.white,
                              textsize: 18.sp,
                              textweight: FontWeight.bold),
                          Padding(
                            padding: EdgeInsets.only(
                                top: padding / 20,
                                left: padding / 20,
                                right: padding / 20),
                            child: SizedBox(
                              height: 5.h,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Secure Your Private Key",
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 241, 195, 86)
                                          // isLightMode
                                          // ? Color.fromARGB(255, 241, 195, 86)
                                          // : Color(0xffFFB800)
                                          ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                            // isLightMode
                                            // ? Color.fromARGB(255, 241, 195, 86)
                                            // : Color(0xffFFB800),
                                            width: 2))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 5.h,
                            width: 66.w,
                            child: NormalOutlineButton(
                              buttontext: "VFDGGGFGFAvudd022ds82sasdsd",
                              pressed: () {},
                              textcolor:
                                  isLightMode ? Colors.black : Colors.white,
                              buttonwidth: 1,
                              buttoncolor: Color.fromARGB(255, 241, 195, 86),
                              //  isLightMode
                              //    ? Color.fromARGB(255, 241, 195, 86)
                              //    : Color(0xffFFB800)
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
                                  pressed: () {
                                    Navigator.pop(context);
                                  },
                                  textcolor: Color.fromARGB(255, 241, 195, 86),
                                  //  isLightMode
                                  //  ? Color.fromARGB(255, 241, 195, 86)
                                  //  : Color(0xffFFB800),
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
                                    buttontext: "Copy",
                                    buttoncolor:
                                        Color.fromARGB(255, 241, 195, 86),
                                    //  isLightMode
                                    //  ? Color.fromARGB(255, 241, 195, 86)
                                    //  : Color(0xffFFB800),
                                    Textcolor: Colors.black,
                                    weightfont: FontWeight.normal,
                                    Pressed: () {},
                                    fontsize: 14.sp),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
              // ? Color.fromARGB(255, 241, 195, 86)
              // : Color(0xffFFB800)
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(padding / 60),
          child: Row(
            children: [
              Icon(
                Icons.lock,
                color: isLightMode ? Colors.black : Colors.white,
                size: 16,
              ),
              SizedBox(
                width: 1.w,
              ),
              Textfile(
                  text: "Secret Key",
                  textcolor: isLightMode ? Colors.black : Colors.white,
                  textsize: 13.5.sp,
                  textweight: FontWeight.normal)
            ],
          ),
        ),
      ),
    );
  }
}
