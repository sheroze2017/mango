import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sbgwallet/Controller/recoverAccount.dart';
import 'Components/Number_text.dart';
import 'Components/Textfile.dart';
import 'Components/RoundedButton.dart';
import 'Dialog/Dialog_Terms_of_use.dart';
import 'Switch_button.dart';

class Recovery_Phrase extends StatefulWidget {
  const Recovery_Phrase({super.key});

  @override
  State<Recovery_Phrase> createState() => _Recovery_PhraseState();
}

class _Recovery_PhraseState extends State<Recovery_Phrase> {
  List<String> userInputList = List.filled(12, '');
  List<TextEditingController> controllers = [];
  TextEditingController _password = TextEditingController(text: "");
  TextEditingController _confirmpassword = TextEditingController(text: "");
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < 12; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }

  void showTryAgainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Try again'),
        content: Text('No Account exist.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
  final focus10 = FocusNode();
  final focus11 = FocusNode();
  final focus12 = FocusNode();
  final focus13 = FocusNode();
  final focus14 = FocusNode();
  final focus15 = FocusNode();

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final recovercontroller = Get.put(recoverAccount());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: padding / 12,
            left: padding / 20,
            right: padding / 20,
            bottom: padding / 20),
        child: Container(
          child: SingleChildScrollView(
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
                Textfile(
                  text: 'Recovery Phrase?',
                  textcolor: isLightMode ? Colors.black : Colors.white,
                  textsize: 20.sp,
                  textweight: FontWeight.bold,
                ).animate(delay: 1000.ms).scaleX(),
                SizedBox(
                  height: 1.h,
                ),
                Textfile(
                  text:
                      'Only the first account on this wallet will auto load. After completing this process, to add additional accounts, click the drop down menu, then select create Account.',
                  textcolor: isLightMode ? Colors.black : Colors.white,
                  textsize: 14.sp,
                  textweight: FontWeight.normal,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Textfile(
                      text: 'Set Recovery Phrase',
                      textcolor: isLightMode ? Colors.black : Colors.white,
                      textsize: 16.sp,
                      textweight: FontWeight.normal,
                    ),

                    SizedBox(
                      width: 16.w,
                    ),
                    //  SizedBox(
                    //    height: 3.h,
                    //    width: 35.w,
                    //    child: NormalOutlineButton(
                    //    buttontext: "I have 12 word Phrase",
                    //    pressed: (){},
                    //    textcolor: Colors.grey,
                    //    textsize: 12.sp,
                    //    textweight: FontWeight.normal,
                    //    buttoncolor: Colors.grey, buttonwidth: 1,
                    //    ),
                    //  ),
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '1.'),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              controller: controllers[0],
                              onChanged: (value) {
                                userInputList[0] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              //controllers[index] = textEditingController;

                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '2.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus,
                              controller: controllers[1],
                              onChanged: (value) {
                                userInputList[1] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus1);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '3.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus1,
                              controller: controllers[2],
                              onChanged: (value) {
                                userInputList[2] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus2);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '4.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus2,
                              controller: controllers[3],
                              onChanged: (value) {
                                userInputList[3] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus3);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '5.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus3,
                              controller: controllers[4],
                              onChanged: (value) {
                                userInputList[4] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus4);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '6.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus4,
                              controller: controllers[5],
                              onChanged: (value) {
                                userInputList[5] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus5);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '7.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus5,
                              controller: controllers[6],
                              onChanged: (value) {
                                userInputList[6] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus6);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '8.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus6,
                              controller: controllers[7],
                              onChanged: (value) {
                                userInputList[7] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus7);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '9.'),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus7,
                              controller: controllers[8],
                              onChanged: (value) {
                                userInputList[8] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus8);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '10.'),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus8,
                              controller: controllers[9],
                              onChanged: (value) {
                                userInputList[9] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus9);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '11.'),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus9,
                              controller: controllers[10],
                              onChanged: (value) {
                                userInputList[10] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus10);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Number_text(text: '12.'),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            height: 4.h,
                            width: 35.w,
                            child: TextFormField(
                              focusNode: focus10,
                              controller: controllers[11],
                              onChanged: (value) {
                                userInputList[11] = value.toLowerCase();
                                print(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus11);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textfile(
                            text: "New Password (8 Characters min)",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 14.sp,
                            textweight: FontWeight.normal),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: padding / 3.5),
                          child: SizedBox(
                            height: 4.h,
                            width: 50.w,
                            child: TextFormField(
                              focusNode: focus11,

                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(focus12);
                              },
                              controller: _password,
                              // obscureText: hidepassword,
                              validator: (String? value) {
                                // if(value?.isEmpty)
                                //   {
                                //     return "Please Enter Password ";
                                //   }

                                if (value?.length != 8) {
                                  return "password length must be 8";
                                }
                                return null;
                              },
                              onSaved: (String? pass) {
                                _password = pass as TextEditingController;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textfile(
                            text: "Confirm Password",
                            textcolor:
                                isLightMode ? Colors.black : Colors.white,
                            textsize: 14.sp,
                            textweight: FontWeight.normal),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: padding / 3.5),
                          child: SizedBox(
                            height: 4.h,
                            width: 50.w,
                            child: TextFormField(
                              focusNode: focus12,

                              controller: _confirmpassword,
                              //obscureText: hidepass,
                              // onFieldSubmitted: (value) {
                              //   FocusScope.of(context).requestFocus(focus13);
                              // },
                              validator: (String? value) {
                                // if(value?.isEmpty)
                                //   {
                                //     return "Please Enter Password ";
                                //   }

                                if (value?.length != 8) {
                                  return "password length must be 8 ";
                                }
                                if (_password.text != _confirmpassword.text) {
                                  return "password do not match";
                                }
                                //  print(_confirmpassword);
                                return null;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  fillColor: Color.fromARGB(255, 241, 195, 86),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 241, 195, 86),
                                      ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: padding / 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Dialog_term_of_use(),
                          //  Richtextfile(
                          //  text1: "I have read and agree to the",
                          //  text2: "Terms of use",
                          //  click: (){},
                          //  text1color: Colors.black, text2color: Color.fromARGB(255, 241, 195, 86),
                          //  text1size: 14.sp, text1weight: FontWeight.normal,
                          //  text2size: 14.sp, text2weight: FontWeight.normal,
                          //  text1space: 1, text2space: 1),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 5.h,
                            width: 30.w,
                            child: RoundedButton(
                              Pressed: () async {
                                String word = await userInputList
                                    .sublist(0, userInputList.length)
                                    .join(" ");
                                print(_confirmpassword.text);
                                print(_password.text);
                                if (_password.text == _confirmpassword.text) {
                                  if (_password.text.length == 8) {
                                    print(userInputList);
                                    recovercontroller.fetch(
                                        word.toString(), _password.text);

                                    // recoverAccount().fetch(word.toString());
                                    // _storage.write(
                                    //     key: 'password',
                                    //     value: _confirmpassword.text);

                                    //  print(_password );
                                  } else {
                                    Get.snackbar('Message',
                                        'Password length must be greater',
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.white,
                                        colorText: Colors.black);
                                  }
                                } else {
                                  Get.snackbar(
                                      'Message', 'Password do not match',
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.black);
                                }
                                ;
                                // print(userInputList);
                                // String word = await userInputList
                                //     .sublist(0, userInputList.length)
                                //     .join(" ");

                                // print(word);
                                // recoverAccount().fetch(word.toString());
                                // recoverData(
                                //   );
                              },
                              Textcolor: Colors.black,
                              buttoncolor: Color.fromARGB(255, 241, 195, 86),
                              buttontext: 'Import',
                              weightfont: FontWeight.normal,
                              fontsize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
