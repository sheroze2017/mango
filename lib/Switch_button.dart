import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Controller/themeController.dart';
import 'My_theme.dart';

class Switch_button extends StatefulWidget {
  
  const Switch_button({super.key});

  @override
  State<Switch_button> createState() => _Switch_buttonState();
}

class _Switch_buttonState extends State<Switch_button> {
  @override
  Widget build(BuildContext context) {
     Get.put(ThemeController());
    return 
    // GetBuilder<ThemeController>(
    //       builder: (controller) =>  IconButton(
    //           icon: Icon(
    //             controller.isDarkMode ? _Darkicon : _Lighticon,
    //           ),
    //        onPressed: () => controller.toggleDarkMode(),));
          
    IconButton(
                         onPressed: (){
                setState(() {
            
                _icon? Get.changeTheme(ThemeClass.lightTheme) :Get.changeTheme(ThemeClass.darkTheme);
                 _icon = !_icon;
                });
                         }, 
                         
                       
                       icon: Icon(_icon ?  _Darkicon :_Lighticon
                        
                           )
                         );
  }
}
bool _icon = true;

IconData _Lighticon = Icons.wb_sunny;
IconData _Darkicon  = Icons.nights_stay;