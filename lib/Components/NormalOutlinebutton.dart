import 'package:flutter/material.dart';
import 'package:sbgwallet/Components/Textfile.dart';

class NormalOutlineButton extends StatelessWidget {
     final pressed, textcolor, textsize, textweight, buttoncolor;
     final String buttontext;
     final double buttonwidth;
   NormalOutlineButton({
       required this.buttontext,
       required this.pressed,
       required this.textcolor, this.textsize, this.textweight,
       required this.buttonwidth,
       required this.buttoncolor
   });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
         color: buttoncolor,
         width: buttonwidth
        ), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        
        )
      ),
      onPressed: pressed,
      child: Textfile(
      text: buttontext, 
      textcolor: textcolor, 
      textsize: textsize, textweight: textweight),
    );
  }
}