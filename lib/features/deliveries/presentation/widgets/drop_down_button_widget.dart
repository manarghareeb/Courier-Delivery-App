import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget({
    super.key,
    required this.hintText,
    required this.types,
    required this.onChange,
  });

  final String hintText;
  final List<String> types;
  final void Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(10.r),
      hint: Text(hintText),
      style: TextStyles.font14WhiteNormal.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.textFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      value: null,
      items: types.map((method) {
        return DropdownMenuItem<String>(
          value: method.toLowerCase(),
          child: Text(method),
        );
      }).toList(),
      onChanged: onChange,
    );
  }
}
