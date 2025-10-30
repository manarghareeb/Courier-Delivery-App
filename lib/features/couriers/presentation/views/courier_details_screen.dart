import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/couriers/data/courier_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourierDetailScreen extends StatefulWidget {
  //final Map<String, dynamic> courier;
  //final String userId;
  //final Function(double) onRate;
  final CourierModel courier;
  const CourierDetailScreen({
    super.key,
    required this.courier,
    //required this.userId, required this.onRate
  });

  @override
  State<CourierDetailScreen> createState() => _CourierDetailScreenState();
}

class _CourierDetailScreenState extends State<CourierDetailScreen> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = (widget.courier.rating).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.courier.name)),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.courier.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    index < currentRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      currentRating = index + 1.0;
                    });
                    //widget.onRate(currentRating);
                  },
                );
              }),
            ),
            SizedBox(height: 16.h),
            Text(
              'Package Info',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              '- Weight: 2kg\n- Size: Medium\n- Contents: Electronics',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 16.h),
            Text(
              'From / To Locations',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'From: Cairo, Egypt\nTo: Alexandria, Egypt',
              style: TextStyles.font14GreyNormalItalic,
            ),
            SizedBox(height: 16.h),
            Text(
              'Estimated Time & Price',
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'Time: ${widget.courier.estimatedTime}\nPrice: \$20',
              style: TextStyles.font14GreyNormalItalic,
            ),
          ],
        ),
      ),
    );
  }
}
