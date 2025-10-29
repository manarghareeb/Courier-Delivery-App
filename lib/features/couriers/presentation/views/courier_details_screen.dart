import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourierDetailScreen extends StatelessWidget {
  final Map<String, dynamic> courier;
  const CourierDetailScreen({super.key, required this.courier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(courier['name'])),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(courier['name'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 4.w),
                    Text('4.5'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text('Package Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              '- Weight: 2kg\n- Size: Medium\n- Contents: Electronics',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 16.h),
            Text('From / To Locations',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'From: Cairo, Egypt\nTo: Alexandria, Egypt',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 16.h),
            Text('Estimated Time & Price',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'Time: 2h 30m\nPrice: \$20',
              style: TextStyles.font14GreyNormalItalic,
            ),
          ],
        ),
      ),
    );
  }
}
