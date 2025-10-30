import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageInfoSection extends StatelessWidget {
  const PackageInfoSection({
    super.key,
    required this.weightController,
    required this.weightKey,
    required this.sizeController,
    required this.sizeKey,
    required this.contentsController,
    required this.contentsKey,
  });

  final TextEditingController weightController;
  final GlobalKey<FormState> weightKey;
  final TextEditingController sizeController;
  final GlobalKey<FormState> sizeKey;
  final TextEditingController contentsController;
  final GlobalKey<FormState> contentsKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFieldWidget(
          controller: weightController,
          hintText: 'Weight',
          textInputType: TextInputType.number,
          title: 'Weight',
          formKey: weightKey,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter package weight";
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWidget(
          controller: sizeController,
          hintText: 'Size',
          textInputType: TextInputType.text,
          title: 'Size',
          formKey: sizeKey,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter package size";
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWidget(
          controller: contentsController,
          hintText: 'Contents',
          textInputType: TextInputType.text,
          title: 'Contents',
          formKey: contentsKey,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter package contents";
            }
            return null;
          },
        ),
      ],
    );
  }
}
