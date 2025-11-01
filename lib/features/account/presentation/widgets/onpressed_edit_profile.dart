import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:courier_delivery_app/core/widgets/yes_cancel_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnPressedOnEditProfile extends StatelessWidget {
  const OnPressedOnEditProfile({
    super.key,
    required this.nameController,
    required this.nameKey,
    required this.phoneController,
    required this.phoneKey,
    required this.passwordController,
    required this.passwordKey,
  });

  final TextEditingController nameController;
  final GlobalKey<FormState> nameKey;
  final TextEditingController phoneController;
  final GlobalKey<FormState> phoneKey;
  final TextEditingController passwordController;
  final GlobalKey<FormState> passwordKey;

  Future<void> updateProfileWithPass(BuildContext context) async {
    if (!(nameKey.currentState?.validate() ?? true) ||
        !(phoneKey.currentState?.validate() ?? true) ||
        !(passwordKey.currentState?.validate() ?? true)) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userId = user.uid;
    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);

    final updatedName =
        nameController.text.trim().isEmpty
            ? CacheHelper.getData('name') ?? ''
            : nameController.text.trim();
    final updatedPhone =
        phoneController.text.trim().isEmpty
            ? CacheHelper.getData('phone') ?? ''
            : phoneController.text.trim();
    final updatedPassword = passwordController.text.trim();

    final dataToUpdate = <String, dynamic>{
      'name': updatedName,
      'phone': updatedPhone,
    };

    if (updatedPassword.isNotEmpty) {
      try {
        await user.updatePassword(updatedPassword);
        dataToUpdate['password'] = updatedPassword;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update password: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    try {
      await docRef.update(dataToUpdate);
      CacheHelper.saveData(key: 'name', value: updatedName);
      CacheHelper.saveData(key: 'phone', value: updatedPhone);
      if (updatedPassword.isNotEmpty) {
        CacheHelper.saveData(key: 'password', value: updatedPassword);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            hintText: '${CacheHelper.getData('name')}',
            textInputType: TextInputType.name,
            title: "${CacheHelper.getData('name')}",
            formKey: nameKey,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            controller: phoneController,
            hintText: '${CacheHelper.getData('phone')}',
            textInputType: TextInputType.phone,
            title: "${CacheHelper.getData('phone')}",
            formKey: phoneKey,
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWidget(
            controller: passwordController,
            hintText: '${CacheHelper.getData('password')}',
            textInputType: TextInputType.text,
            title: "${CacheHelper.getData('password')}",
            formKey: passwordKey,
          ),
        ],
      ),
      actions: [
        YesAndCancelInAlertDialog(
          onPressedYes: () {
            updateProfileWithPass(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Edit Profile pressed'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ],
    );
  }
}
