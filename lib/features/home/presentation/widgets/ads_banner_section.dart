import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsBannerSection extends StatelessWidget {
  const AdsBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'See All Offer\'s',
          style: TextStyles.font12GreyNormalItalic.copyWith(
            fontStyle: FontStyle.normal,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: const DecorationImage(
              image: AssetImage('assets/Offer Banner (1).png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
