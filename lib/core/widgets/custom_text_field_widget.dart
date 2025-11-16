import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.obscureText = false,
    this.validator,
    required this.title,
    required this.formKey,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String title;
  final GlobalKey<FormState> formKey;
  final IconData? suffixIcon;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText == true ? isObscured : false,
        validator: widget.validator,
        style: TextStyles.font14WhiteNormal.copyWith(color: Colors.black),
        decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: ColorManager.textFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                )
              : (widget.suffixIcon != null ? Icon(widget.suffixIcon) : null),
        ),
      ),
    );
  }
}
