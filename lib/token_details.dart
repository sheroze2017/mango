import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';

class TokenDetailsPage extends StatelessWidget {
  final String? tokenSymbol;
  final String? tokenName;
  final String? tokenPrice;
  final String? address;

  TokenDetailsPage(
      {required this.tokenSymbol,
      required this.tokenName,
      required this.tokenPrice,
      required this.address});

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () => Get.back(),
                  ),
                  SizedBox(
                    width: 31.w,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Token Details',
                        ),
                        Text(
                          tokenName!,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text('Token'),
              SizedBox(
                width: 1.w,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    //make border radius more than 50% of square height & width
                    child: Image.asset(
                      "Assets/Mango Wallet.png",
                      height: 10.w,
                      width: 10.w,
                      fit: BoxFit.cover, //change image fill type
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    tokenSymbol!,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                'Token Amount',
                style: TextStyle(fontSize: 15),
              )

              //SizedBox(height: 8.0),
              ,
              Text(
                tokenPrice!,
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 5.h),
              Text(
                'Token contract address',
                style: TextStyle(fontSize: 15),
              )

              //SizedBox(height: 8.0),
              ,
              Container(
                width: 33.w,
                height: 3.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(0, 158, 158, 158)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 1.5.h,
                        width: 22.w,
                        child: Text(
                          address!,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 241, 195, 86)),
                        )),
                    GestureDetector(
                      onTap: () async {
                        //print(private_key);
                        // print(WController.balance);
                        Clipboard.setData(new ClipboardData(text: address))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Copied to your clipboard')));
                        });
                      },
                      child: Icon(
                        Icons.copy,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              // Text(
              //   'Token Decimal',
              //   style: TextStyle(fontSize: 15),
              // )

              // //SizedBox(height: 8.0),
              // ,
              // Text(
              //   address!.length.toString(),
              //   style: TextStyle(fontSize: 13),
              // ),
              // SizedBox(height: 5.h),
              Text(
                'Network',
                style: TextStyle(fontSize: 15),
              )

              //SizedBox(height: 8.0),
              ,
              Text(
                tokenName!,
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 5.h),
              Text(
                'Token Lists',
                style: TextStyle(fontSize: 15),
              )

              //SizedBox(height: 8.0),
              ,
              Text(
                'Dynamic',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
