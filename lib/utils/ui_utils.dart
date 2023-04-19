import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiUtils {
  Widget gapWidget({double? height = 0, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget loadingWidget() {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(AppColors.blue11),
    );
  }

  Widget appButton(
      {required VoidCallback? onPressFunction,
      String? buttonText,
      Color? buttonFillColor,
      Color? buttonBorderColor,
      Color? buttonTextColor}) {
    return Container(
      height: 56,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonFillColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: buttonBorderColor!)))),
          onPressed: () {
            onPressFunction != null ? onPressFunction() : null;
          },
          child: Center(
              child: Text(
            buttonText ?? "N/A",
            style: TextStyle(
                fontSize: screenWidth / 18,
                fontWeight: FontWeight.w500,
                color: buttonTextColor,
                decoration: TextDecoration.none),
          ))),
    );
  }

  EdgeInsets setDiffPadding(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  EdgeInsets setAllPadding(double value) {
    return EdgeInsets.all(value);
  }

  Widget appTextButton(
      {required VoidCallback onPressFunction,
      String? buttonText,
      Color? buttonTextColor,
      bool? isLinkText = false}) {
    return TextButton(
        onPressed: () {
          onPressFunction();
        },
        child: Text(buttonText ?? "N/A",
            style: TextStyle(
                color: buttonTextColor,
                fontSize: screenWidth / 22,
                letterSpacing: 0.25,
                fontWeight: FontWeight.w500,
                decoration: isLinkText == false
                    ? TextDecoration.none
                    : TextDecoration.underline)));
  }

  showLogMessage({
    required var className,
    required String functionName,
    required String message,
  }) {
    if (message.isNotEmpty && kDebugMode)
      return debugPrint(
          "className : $className , functionName: $functionName , message :$message");
  }

  Widget dividerWidget() {
    return const Divider(
      color: AppColors.grayE6,
      thickness: 1.0,
    );
  }
}
