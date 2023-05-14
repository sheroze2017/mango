import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:sbgwallet/Components/RoundedButton.dart';
import 'Components/Video.dart';
import 'Switch_button.dart';
import 'WalletPage_assets.dart';

class Secure_walletvideo extends StatelessWidget {
  const Secure_walletvideo({super.key});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'VIDEO_ID',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    final List<dynamic> arguments = Get.arguments;
    final String phrase = arguments[0];
    final String address = arguments[1];
    final String private_key = arguments[2];

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
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "Assets/finallogo.png",
                      scale: 2,
                    ),
                    Switch_button(),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Textfile(
                      text: "Secure your Wallet",
                      textcolor: isLightMode ? Colors.black : Colors.white,
                      textsize: 24.sp,
                      textweight: FontWeight.bold)
                  .animate(delay: 1000.ms)
                  .scaleX(),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: padding / 14, right: padding / 14),
                child: Textfile(
                    text:
                        "Before getting started watch this short video to learn about your Secret Recovery Phrase and how to keep your wallet safe.",
                    textcolor: isLightMode ? Colors.black : Colors.white,
                    textsize: 15.sp,
                    textweight: FontWeight.normal),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                height: 25.h,
                width: 80.w,
                color: Colors.black,
                child: Video(),
              ),
              SizedBox(
                height: 2.2.h,
              ),
              Container(
                height: 33.h,
                width: 80.w,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 241, 195, 86), width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: padding / 40, bottom: padding / 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding / 30),
                        child: Textfile(
                            text: "What is your Secret Recovery Phrase?",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 15.sp,
                            textweight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text:
                                "Your Secret Recovery Phrase is a 12-word phrase that is the “Master Key” to your wallet and funds.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 1.1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text: "How do I save my Secret Recovery Phrase",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 15.sp,
                            textweight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 0.55.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text: "Save in a password manager.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text: "Store in a bank wallet.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text: "Store in save deposit box.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text:
                                "Write down and store in multiple secret places.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 1.1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text: "Should I share my Secret Recovery Phrase?",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 15.sp,
                            textweight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 0.6.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text:
                                "Never, ever share your Secret Recovery Phrase.Not even with Mango Wallet!",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: padding / 30, right: padding / 30),
                        child: Textfile(
                            text:
                                "If someone asks for your recovery phrase they are likely trying to scam you and steal your wallet funds.",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 13.sp,
                            textweight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.2.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: padding / 2),
                child: SizedBox(
                  height: 5.5.h,
                  width: 30.w,
                  child: RoundedButton(
                      buttontext: "Create",
                      buttoncolor: Color.fromARGB(255, 241, 195, 86),
                      Textcolor: Colors.black,
                      weightfont: FontWeight.normal,
                      Pressed: () {
                        print(phrase + address + private_key);
                        //Get.offAllNamed('/home');
                        Get.offAll(() => WalletPage_asset(),
                            arguments: [phrase, address, private_key]);
                      },
                      fontsize: 14.sp),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
