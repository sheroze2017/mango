import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttontext;
  final buttoncolor, Textcolor;
  final weightfont, fontsize;
  final Pressed;

 RoundedButton({
     required this.buttontext,
     required this.buttoncolor,
     required this.Textcolor,
     required this.weightfont,
     required this.Pressed,
     required this.fontsize
   
     
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: Pressed,
      child: Text(buttontext,
       style: TextStyle(
        color: Textcolor,
        fontWeight: weightfont,
        fontSize: fontsize
       ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
          
        ),
        backgroundColor: buttoncolor
           
      )
    );
  }
}