import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  // style for main title
  static TextStyle font32MainColorBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.mainColor,
  );
  // style for button text
  static TextStyle font16WhiteW600 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  // style for normal white text in onboarding screen
  static TextStyle font14WhiteNormal = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
  // style for header1 text
  static TextStyle font20BlackBoldItalic = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontStyle: FontStyle.italic,
  );

  static TextStyle font12GreyNormalItalic = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorManager.geyColor,
      fontStyle: FontStyle.italic);

  static TextStyle font14GreyNormalItalic = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorManager.geyColor,
      fontStyle: FontStyle.italic);

  static TextStyle font12BlackBoldNormal = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontStyle: FontStyle.normal);

  static TextStyle font10BlackW700Italic = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      color: ColorManager.geyColor,
      fontStyle: FontStyle.italic);
}
