import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiverInfoSection extends StatelessWidget {
  const ReceiverInfoSection({super.key, required this.nameController, required this.nameKey, required this.phoneController, required this.phoneKey, required this.addressController, required this.addressKey, required this.locationController, required this.locationKey});

  final TextEditingController nameController;
  final GlobalKey<FormState> nameKey;
  final TextEditingController phoneController;
  final GlobalKey<FormState> phoneKey;
  final TextEditingController addressController;
  final GlobalKey<FormState> addressKey;
  final TextEditingController locationController;
  final GlobalKey<FormState> locationKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFieldWidget(
          controller: nameController,
          hintText: 'Name',
          textInputType: TextInputType.text,
          title: 'Name',
          formKey: nameKey,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWidget(
          controller: phoneController,
          hintText: 'Phone',
          textInputType: TextInputType.phone,
          title: 'Phone',
          formKey: phoneKey,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWidget(
          controller: addressController,
          hintText: 'Address Details',
          textInputType: TextInputType.text,
          title: 'Address Details',
          formKey: addressKey,
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWidget(
          controller: locationController,
          hintText: 'Location',
          textInputType: TextInputType.text,
          title: 'Location',
          formKey: locationKey,
        ),
      ],
    );
  }
}
