import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Blob.png',
          width: 283.w,
          height: 295.h,
        ),
        Positioned(
          top: 80.h,
          left: 40.w,
          child: Image.asset(
            'assets/logo.png',
            width: 210.w,
            height: 120.h,
          ),
        ),
      ],
    );
  }
}
