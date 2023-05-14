import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'Components/NormalOutlinebutton.dart';
import 'Components/RoundedButton.dart';
import 'Components/Textfile.dart';

final _storage = FlutterSecureStorage();

final private_key = Get.arguments;

Future<Album> fetchAlbum() async {
  print(private_key);
  final response = await http.get(
    Uri.parse('https://sbgwallet.io:9000/api/decrypt?input=' + private_key),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Product {
  final String product_image;

  //final String createdAt;

  Product({
    required this.product_image,
    //required this.createdAt
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_image: json['privateKey'],
      // createdAt: json['iat']
    );
  }
}

class Album {
  final Product privateKey;

  Album({
    required this.privateKey,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      privateKey: Product.fromJson(json['privateKey']),
    );
  }
}

class PromotionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? data = '';
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    final arg = ModalRoute.of(context)?.settings.arguments;
    Future<Album> futureAlbum = fetchAlbum();

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
          height: 45.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Textfile(
                  text: "Secret Key",
                  textcolor: isLightMode ? Colors.black : Colors.white,
                  textsize: 22.sp,
                  textweight: FontWeight.bold),
              Padding(
                padding: EdgeInsets.only(
                    top: padding / 20, left: padding / 20, right: padding / 20),
                child: SizedBox(
                  height: 5.h,
                  child: Text("Do Not Share Your private key With Anyone"),
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
                    child: FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data!.privateKey.product_image);
                          data = snapshot.data?.privateKey.product_image;
                          _storage.write(
                              key: 'encryptPK',
                              value: snapshot.data!.privateKey.product_image);
                          return Text(snapshot.data!.privateKey.product_image);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator(
                            color: Color.fromARGB(255, 241, 195, 86));
                      },
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
                      pressed: () {
                        Get.back();
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
                    child: RoundedButton(
                        buttontext: "Copy",
                        buttoncolor: Color.fromARGB(255, 241, 195, 86),
                        //  isLightMode
                        //  ? Color.fromARGB(255, 241, 195, 86)
                        //  : Color(0xffFFB800),
                        Textcolor: Colors.black,
                        weightfont: FontWeight.normal,
                        Pressed: () async {
                          //print("Secret key copy screen " + data!);
                          Clipboard.setData(new ClipboardData(text: data))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Copied to your clipboard !')));
                          });
                        },
                        fontsize: 14.sp),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
