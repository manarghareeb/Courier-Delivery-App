import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:courier_delivery_app/core/widgets/yes_cancel_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnPressedOnEditProfile extends StatelessWidget {
  const OnPressedOnEditProfile({
    super.key,
    required this.nameController,
    required this.nameKey,
    required this.emailController,
    required this.emailKey,
    required this.phoneController,
    required this.phoneKey,
  });

  final TextEditingController nameController;
  final GlobalKey<FormState> nameKey;
  final TextEditingController emailController;
  final GlobalKey<FormState> emailKey;
  final TextEditingController phoneController;
  final GlobalKey<FormState> phoneKey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Edit Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFieldWidget(
            controller: nameController,
            hintText: 'Name',
            textInputType: TextInputType.name,
            title: "Name",
            formKey: nameKey,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            controller: emailController,
            hintText: 'Email',
            textInputType: TextInputType.name,
            title: "Email",
            formKey: emailKey,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            controller: phoneController,
            hintText: 'Phone',
            textInputType: TextInputType.phone,
            title: "Phone",
            formKey: phoneKey,
          ),
        ],
      ),
      actions: [
        YesAndCancelInAlertDialog(onPressedYes: (){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Edit Profile pressed'),
              backgroundColor: Colors.green,
            ),
          );
        })
      ],
    );
  }
}
