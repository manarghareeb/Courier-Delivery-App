import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/small_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageDetailsScreen extends StatelessWidget {
  final Map<String, String> package;
  const PackageDetailsScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(package['id'] ?? 'Package Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text(
              'ID: ${package['id']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Date: ${package['date']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Receiver Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text(
              'Name: ${package['receiver']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Address: ${package['address']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Phone: ${package['phone']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Payment & Price',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            Text(
              'Method: ${package['payment']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            Text(
              'Price: ${package['price']}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 10.h),
            Text(
              'Delivery Status: ${package['status']}',
              style: const TextStyle(color: Colors.blue),
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallTextButtomWidget(
                  title: 'Add Review',
                  onPressed: (){},
                ),
                SmallTextButtomWidget(
                  title: 'Courier Review',
                  onPressed: (){},
                ),
                SmallTextButtomWidget(
                  title: 'Invoice',
                  onPressed: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
