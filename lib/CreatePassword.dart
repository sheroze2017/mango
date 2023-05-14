import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Components/Textfile.dart';
import 'Components/RoundedButton.dart';
import 'Dialog/Dialog_Terms_of_use.dart';
import 'Switch_button.dart';
import 'YourSecretPhrase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

String name = "User";

class _CreatePasswordState extends State<CreatePassword> {
  TextEditingController _password = TextEditingController(text: "");
  TextEditingController _confirmpassword = TextEditingController(text: "");

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  bool hidepassword = true;
  bool hidepass = true;

  final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Stack(
      children: [
        Container(
          color: isLightMode ? Colors.white : Colors.black,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/bgpass.png"), fit: BoxFit.cover)),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(
                top: padding / 12,
                left: padding / 20,
                right: padding / 20,
                bottom: padding / 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Column(
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
                      height: 12.h,
                    ),
                    Textfile(
                        text: "Create Password",
                        textcolor: isLightMode ? Colors.black : Colors.white,
                        textsize: 26.sp,
                        textweight: FontWeight.bold),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: padding / 50, right: padding / 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textfile(
                              text: "New Password (8 characters)",
                              textcolor:
                                  isLightMode ? Colors.black : Colors.white,
                              textsize: 15.sp,
                              textweight: FontWeight.normal),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          SizedBox(
                            height: 10.h,
                            width: 75.w,
                            child: TextFormField(
                              controller: _password,
                              obscureText: hidepassword,
                              validator: (String? value) {
                                // if(value?.isEmpty)
                                //   {
                                //     return "Please Enter Password ";
                                //   }

                                if (value?.length! != 8) {
                                  return "password length must be 8";
                                }
                                return null;
                              },
                              onSaved: (String? pass) {
                                _password = pass as TextEditingController;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidepassword = !hidepassword;
                                      });
                                    },
                                    icon: hidepassword
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                          )),
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 241, 195, 86),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 241, 195, 86),
                                      width: 1.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 241, 195, 86),
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 241, 195, 86),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: padding / 50, right: padding / 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textfile(
                              text: "Confirm Password",
                              textcolor:
                                  isLightMode ? Colors.black : Colors.white,
                              textsize: 15.sp,
                              textweight: FontWeight.normal),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          SizedBox(
                            height: 10.h,
                            width: 75.w,
                            child: TextFormField(
                              controller: _confirmpassword,
                              obscureText: hidepass,
                              validator: (String? value) {
                                // if(value?.isEmpty)
                                //   {
                                //     return "Please Enter Password ";
                                //   }

                                if (value?.length! != 8) {
                                  return "password length must be 8 ";
                                }
                                if (_password.text != _confirmpassword.text) {
                                  return "password do not match";
                                }
                                //  print(_confirmpassword);
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidepass = !hidepass;
                                      });
                                    },
                                    icon: hidepass
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Color.fromARGB(
                                                255, 241, 195, 86),
                                          )),
                                hintText: "Confirm Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 241, 195, 86),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 241, 195, 86),
                                      width: 1.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 241, 195, 86),
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 241, 195, 86),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Dialog_term_of_use(),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 5.h,
                          width: 30.w,
                          child: RoundedButton(
                            Pressed: () async {
                              setState(() {
                                //_fetchData();
                                if (_confirmpassword.text.length != 8 ||
                                    _password.text.length != 8) {
                                  Get.snackbar(
                                      'Error', 'Password length must be 8',
                                      backgroundColor: Colors.white,
                                      colorText: Colors.black);
                                } else if (_formKey1.currentState!.validate() &&
                                    (_confirmpassword.text == _password.text)) {
                                  _storage.write(
                                      key: 'password',
                                      value: _confirmpassword.text);

                                  //  print(_password );
                                  Get.to(() => MyApp());
                                  // print(_confirmpassword.text);
                                  // saveMyName(_confirmpassword.text);
                                  //     _storage.write(key: 'password', value: _confirmpassword.text);
                                  print('Password saved successfully!');
                                } else if (_confirmpassword.text.length ==
                                    _password.text.length) {
                                  Get.snackbar('Error', 'Password Not Match',
                                      backgroundColor: Colors.white,
                                      colorText: Colors.black);
                                }
                              });
                            },
                            Textcolor: Colors.black,
                            buttoncolor: Color.fromARGB(255, 241, 195, 86),
                            buttontext: 'Create',
                            weightfont: FontWeight.normal,
                            fontsize: 15.sp,
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     // ElevatedButton(
                        //     //   child: Text('Retrieve Password'),
                        //     //   onPressed: () async {
                        //     //     final password = await _storage.read(key: 'password');
                        //     //     print('Password retrieved successfully: $password');
                        //     //   },
                        //     // ),
                        //     // Text("${obj.toString()}"),
                        //     // Text("${obj.toString()}")
                        //   ],
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveMyName(String name) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('pwd', name);
  }

  Future<void> getMyName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('pwd') ?? "Name not found";
    });
  }

  Future<void> removeMyName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('pwd');
  }
}
