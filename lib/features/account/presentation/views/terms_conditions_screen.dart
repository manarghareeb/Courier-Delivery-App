import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Text(
            '''
Welcome to Courier Delivery App!

By using our app, you agree to the following terms:

1. You must provide accurate delivery information.
2. Payment methods must be valid and authorized.
3. We are not responsible for delays due to unforeseen events.
4. Your data will be handled according to our privacy policy.

Thank you for using our services!
''',
            style: TextStyles.font14WhiteNormal.copyWith(
              color: Colors.black,
              fontSize: 16.sp,
              height: 1.5.h,
            ),
          ),
        ),
      ),
    );
  }
}
