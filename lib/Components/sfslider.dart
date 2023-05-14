import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onValueChanged;

  CustomSlider({required this.initialValue, required this.onValueChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      child: SfSlider(
        activeColor: Color.fromARGB(255, 241, 195, 86),
        inactiveColor: Color.fromARGB(255, 241, 195, 86),
        min: 0,
        max: 100,
        stepSize: 2,
        value: _value,
        interval: 25,
        showTicks: true,
        showLabels: true,
        minorTicksPerInterval: 0,
        // onChanged: (value) {
        //   setState(() {
        //     _value = value;
        //   });
        // },
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onValueChanged(_value); // Call the onValueChanged callback
        },
      ),
    );
  }
}
