import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Number_text extends StatelessWidget {
  final String text;


  
   Number_text({
       required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final  isLightMode = Theme.of(context).brightness == Brightness.light;
    return Text(
                text,
      style: GoogleFonts.titilliumWeb(
        textStyle: TextStyle(
          color: isLightMode
                 ?Colors.black
                 : Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}