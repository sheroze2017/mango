import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../Components/Textfile.dart';

class DialogDeposit extends StatelessWidget {
  final String address;

  const DialogDeposit({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var padding = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        title: Text('QR Code'),
                        content: Center(
                          child: QrImage(
                            foregroundColor:
                                isLightMode ? Colors.white : Colors.white,
                            data: address, // set the data for the QR code
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            child: Text('Back'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Color.fromARGB(255, 241, 195, 86),
                            textColor: Colors.white,
                          )
                          // RoundedButton(
                          //   Pressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          //   Textcolor: isLightMode
                          //       ? Colors.black
                          //       : Colors.white,
                          //   buttoncolor: Color.fromARGB(
                          //       255, 241, 195, 86),
                          //   buttontext: 'close',
                          //   fontsize: 14,
                          //   weightfont: FontWeight.normal,
                          // ),
                        ],
                      ));
            },
            icon: Icon(
              Icons.arrow_circle_down,
              color: Colors.grey,
              size: 35,
            )),
        Textfile(
            text: "Recieve",
            textcolor: isLightMode ? Colors.black : Colors.white,
            textsize: 15.sp,
            textweight: FontWeight.bold),
      ],
    );
  }
}
