import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbgwallet/My_theme.dart';

class ThemeController extends GetxController {

bool isDarkMode = true; 
bool _icon = true;
IconData _Lighticon = Icons.wb_sunny;
IconData _Darkicon  = Icons.nights_stay;

void toggleDarkMode() {
  isDarkMode = !isDarkMode;
  if (isDarkMode) {
   Get.changeTheme(ThemeClass.darkTheme);
  } else {
   Get.changeTheme(ThemeClass.lightTheme);
  }
  icon: Icon(_icon ?  _Darkicon :_Lighticon
                        
                           );
  update();
}
}