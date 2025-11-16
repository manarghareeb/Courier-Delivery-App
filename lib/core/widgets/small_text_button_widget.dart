import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallTextButtomWidget extends StatelessWidget {
  const SmallTextButtomWidget(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        minimumSize: Size(100.w, 40.h),
      ),
      child: Text(
        title,
        style: TextStyles.font14WhiteNormal.copyWith(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
