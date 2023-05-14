import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'package:sbgwallet/Components/RoundedButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Importwallet_Phrase.dart';
import '../Switch_button.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://sbgwallet.io:9000/api/memonic'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String privateKey;
  final String phrase;
  final String address;

  const Album(
      {required this.privateKey, required this.phrase, required this.address});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      address: json['address'],
      privateKey: json['privateKey'],
      phrase: json['phrase'],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // final TextEditingController _controller = TextEditingController();
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    var loom = "This is String";
    String? data = '';
    String? addressdata = '';
    String? keydata = '';

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
                  height: 20.h,
                ),
                Textfile(
                    text: "Your Secret Recovery",
                    textcolor: isLightMode ? Colors.black : Colors.white,
                    textsize: 22.sp,
                    textweight: FontWeight.bold),
                Textfile(
                    text: "Phrase?",
                    textcolor: isLightMode ? Colors.black : Colors.white,
                    textsize: 22.sp,
                    textweight: FontWeight.bold),
                SizedBox(
                  height: 5.h,
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
                  height: 8.h,
                  child: FutureBuilder<Album>(
                    future: _futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          var datakey = [];
                          var dataadd = [];

                          datakey.insert(0, snapshot.data?.privateKey);
                          dataadd.insert(0, snapshot.data?.address);
                          _storage.write(
                              key: 'datakey', value: jsonEncode(datakey));
                          _storage.write(
                              key: 'dataadd', value: jsonEncode(dataadd));
                          _storage.write(
                              key: 'phrase', value: snapshot.data?.phrase);
                          _storage.write(
                              key: 'address', value: snapshot.data?.address);
                          _storage.write(
                              key: 'privatekey',
                              value: snapshot.data?.privateKey);

                          print(snapshot.data?.phrase);
                          data = snapshot.data?.phrase;
                          addressdata = snapshot.data?.address;
                          keydata = snapshot.data?.privateKey;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(data!)),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                      }
                      return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 241, 195, 86));
                    },
                  ),

                  // Text("Hello")
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  height: 5.h,
                  width: 37.w,
                  child: RoundedButton(
                    buttontext: "Next",
                    buttoncolor: Color.fromARGB(255, 241, 195, 86),
                    Textcolor: Colors.black,
                    weightfont: FontWeight.normal,
                    Pressed: () async {
                      await saveMyAddress(addressdata!);
                      await saveMyKey(keydata!);
                      Get.to(() => HomeScreen(),
                          arguments: [data, addressdata, keydata]);
                      // saveMyAddress(addressdata!);
                      // saveMyKey(keydata!);
                    },
                    fontsize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 5.h,
                  width: 37.w,
                  child: RoundedButton(
                    buttontext: "Copy",
                    buttoncolor: Colors.white,
                    Textcolor: isLightMode ? Colors.black : Colors.black,
                    weightfont: FontWeight.normal,
                    Pressed: () async {
                      Clipboard.setData(new ClipboardData(text: data!))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Copied to your clipboard')));
                      });
                    },
                    fontsize: 15.sp,
                  ),
                ),
                // ElevatedButton(
                //   child: Text('Retrieve Password'),
                //   onPressed: () async {
                //     final password = await _storage.read(key: 'password');
                //     print('Password retrieved successfully: $password');
                //   },
                // ),
              ],
            )),
      ),
    );
  }
}

Future<void> saveMyAddress(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('address', name);
}

Future<void> saveMyKey(String name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('key', name);
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sbgwallet/Components/NormalOutlinebutton.dart';
// import 'package:sbgwallet/Components/Textfile.dart';
// import 'package:sbgwallet/Components/RoundedButton.dart';
// import 'Importwallet_Phrase.dart';
// import 'Phrase.dart';
// import 'Switch_button.dart';
//
//
//
// class Your_Secret_Recovery_Phrase extends StatefulWidget {
//   // final String listitems;
//   // const Your_Secret_Recovery_Phrase({
//   //   required this.listitems
//   // });
//
//   @override
//   State<Your_Secret_Recovery_Phrase> createState() => _Your_Secret_Recovery_PhraseState();
// }
//
// class _Your_Secret_Recovery_PhraseState extends State<Your_Secret_Recovery_Phrase> {
//   // get listitems => this.listitems;
//
//  // final String textphrase = "Crane Blind Disorders majors rose orphan down arrive truck car bus phone";
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     var padding = MediaQuery.of(context).size.width;
//     final isLightMode = Theme.of(context).brightness == Brightness.light;
//     // var listitem = listitems;
//     // print({listitem});
//
//
//     //var obj = Get.arguments;
//
//     return Scaffold(
//
//       body: Padding(
//         padding: EdgeInsets.only(top:padding/12,left:padding/20,right:padding/20,bottom:padding/20),
//         child: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//
//               Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset("Assets/icon.png",
//                           scale: 9,
//                           ),
//                           Switch_button(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//            Textfile(
//             text: "Your Secret Recovery",
//             textcolor: isLightMode
//             ? Colors.black
//             : Colors.white,
//             textsize: 22.sp, textweight: FontWeight.bold
//             ),
//             Textfile(
//               text: "Phrase?",
//               textcolor: isLightMode
//             ? Colors.black
//             : Colors.white,
//               textsize: 22.sp, textweight: FontWeight.bold),
//
//               SizedBox(
//                 height: 5.h,
//               ),
//               Container(
//                height: 6.h,
//                 child:
//
//                   Text("Hello")
//                  // Text(Get.arguments.toString())
//
//                   // Row(
//                   //   children: [
//                   //     Text("${listitems.toString()}"),
//                   //   ],
//                   // )
//                 //Phrase(list: 'pp'),
//                // Text( posts![index].phrase! )
//               ),
//
//               //  Container(
//
//               //   width: 85.w,
//               //   child: Padding(
//               //     padding: EdgeInsets.all(padding/50),
//               //     child: SelectableText(
//               //               textphrase,
//               //               style: TextStyle(
//               //                 color: Colors.black
//               //               ),
//               //           showCursor: true,
//
//               //     ),
//
//               //   ),
//               //   decoration: BoxDecoration(
//               //     color: Color.fromARGB(255, 241, 195, 86),
//               //     borderRadius: BorderRadius.circular(10)
//               //   ),
//               //  ),
//               SizedBox(
//                 height: 4.h,
//               ),
//
//
//                  SizedBox(
//                     height: 5.h,
//                     width: 37.w,
//                     child: RoundedButton(
//                     buttontext: "Next",
//                     buttoncolor: Color.fromARGB(255, 241, 195, 86),
//                    Textcolor: Colors.black, weightfont: FontWeight.normal,
//                     Pressed: (){
//                     Get.to(()=>Importwallet_phrase ());
//                     }, fontsize: 15.sp,),
//                   ),
//
//           ],
//         )
//         ),
//       ),
//
//     );
//   }
// }
