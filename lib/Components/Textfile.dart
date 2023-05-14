import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfile extends StatelessWidget {
  final String text;
  final textsize,textweight;
  final textcolor;
  
   Textfile({
    required this.text,
  
    required this.textsize,
    required this.textweight,  this.textcolor, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: textcolor,
          fontSize: textsize,
          fontWeight: textweight
        )
      ),
    );
  }
}