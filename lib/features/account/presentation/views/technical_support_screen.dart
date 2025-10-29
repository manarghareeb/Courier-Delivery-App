import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Technical Support'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyles.font20BlackBoldItalic.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: messageController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Describe your issue here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButtonWidget(
              buttonText: 'Send Message', 
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Message sent!'), 
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
