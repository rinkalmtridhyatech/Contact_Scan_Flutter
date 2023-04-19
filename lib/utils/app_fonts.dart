import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static const helveticaNeue = "HelveticaNeueLight";
  static const helveticaNeueMedium = "helveticaNeueMedium";
  static const helveticaNeueBold = "helveticaNeueBold";
  static const headLine1 = TextStyle(
      fontSize: fontSize_20,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.w800,
      color: AppColors.gray1C,
      decoration: TextDecoration.none);
  static const headLineHome = TextStyle(
      fontSize: fontSize_14,
      fontWeight: FontWeight.bold,
      fontFamily: helveticaNeue,
      color: AppColors.black,
      decoration: TextDecoration.none);
  static const headLine3 = TextStyle(
      fontSize: fontSize_17,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.w400,
      color: AppColors.gray62,
      decoration: TextDecoration.none);
  static const headLine4 = TextStyle(
      fontSize: fontSize_16,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.w800,
      color: AppColors.gray62,
      decoration: TextDecoration.none);
  static const appNameSplash = TextStyle(
      fontSize: fontSize_32,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.bold,
      color: AppColors.blackE3,
      decoration: TextDecoration.none);
  static const infoWidget = TextStyle(
      fontSize: fontSize_20,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      decoration: TextDecoration.none);
  static const appBarTextStyle = TextStyle(
      fontSize: fontSize_20,
      fontFamily: helveticaNeue,
      fontWeight: FontWeight.w800,
      color: AppColors.white,
      decoration: TextDecoration.none);
  static const errorStyle = TextStyle(
      fontSize: fontSize_16,
      color: AppColors.redB6,
      fontFamily: AppFonts.helveticaNeue);
  static const hintStyle = TextStyle(
      color: AppColors.gray1C,
      fontSize: fontSize_16,
      fontWeight: FontWeight.w400,
      fontFamily: AppFonts.helveticaNeue);
  static const inputTextStyle = TextStyle(
      color: AppColors.gray46,
      fontSize: fontSize_16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      fontFamily: AppFonts.helveticaNeue);
  static const bottomNavUnSelectedLabel = TextStyle(
      color: AppColors.black,
      fontSize: fontSize_9,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.helveticaNeue);
  static const buttonTextStyle = TextStyle(
      fontSize: fontSize_24,
      fontFamily: AppFonts.helveticaNeue,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      decoration: TextDecoration.none);
  static const scanResultHeading = TextStyle(
      fontSize: fontSize_24,
      fontFamily: "helveticaNeueMedium",
      fontWeight: FontWeight.bold,
      color: AppColors.blackE3,
      decoration: TextDecoration.none);
}
