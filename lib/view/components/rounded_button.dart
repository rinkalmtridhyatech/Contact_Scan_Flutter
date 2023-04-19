import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String buttonName;
  Color color;

  RoundedButton(
      {Key? key, required Color this.color, required String this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight / 20,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
          child: Text(
        this.buttonName.toUpperCase(),
        style: TextStyle(fontSize: screenHeight / 50, color: AppColors.white),
      )),
    );
  }
}
