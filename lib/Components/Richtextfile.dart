import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Richtextfile extends StatelessWidget {
  final String text1, text2;
  final click,text1color,text1weight,text1size ;
  final text2color,text2weight,text2size;
  final double? text1space,text2space;
  Richtextfile({
      required this.text1,
      required this.text2,
      required this.click,
      required this.text1color,
      required this.text2color,
      required this.text1size,
      required this.text1weight,
      required this.text2size,
      required this.text2weight,
     required this.text1space,
     required this.text2space

  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
    text: text1,
    style: GoogleFonts.tomorrow(
    textStyle: TextStyle(
    color: text1color,
    fontWeight: text1weight,
    fontSize: text1size,
    letterSpacing: text1space
    ),
    ) ,
    
    children: <InlineSpan>[
      WidgetSpan(
        child: 
        SizedBox(
          width: 1.5.w,
        ),
      
      ),
      
      TextSpan(
        text: text2,
        recognizer: new TapGestureRecognizer()..onTap = click,
        style: GoogleFonts.tomorrow(
               textStyle: TextStyle(
               color: text2color,
               fontWeight: text2weight,
               fontSize: text2size,
               letterSpacing: text2space 
    ),
    ) ,
       
      ),
     // TextSpan(text: 'secret?'),
    ],
  ),
    );
  }
}