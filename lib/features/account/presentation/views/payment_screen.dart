import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.ccVisa, color: Colors.grey),
            title: const Text('Visa **** 9876'),
            subtitle: const Text('Expires 12/26'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 20.h),
          CustomButtonWidget(buttonText: 'Add New Card', onPressed: () {}),
        ],
      ),
    );
  }
}
