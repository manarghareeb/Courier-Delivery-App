import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Packers & Movers', style: TextStyles.font32MainColorBold)),
              SizedBox(height: 60.h),
              Text(
                'Enter your email to reset your password',
                style: TextStyles.font12BlackBoldNormal,
              ),
              SizedBox(height: 20.h),
              CustomTextFieldWidget(
                controller: controller,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                title: 'Enter your email',
                formKey: formKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  } else if (value.contains("@gmail.com") == false) {
                    return 'this email is not valid "missing @gmail.com"';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              CustomButtonWidget(
                buttonText: 'Send Reset Email',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: controller.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password reset email sent! Check your inbox.',
                          ),
                        ),
                      );
                      GoRouter.of(context).push(AppRouter.loginScreen);
                    } on FirebaseAuthException catch (e) {
                      String message = 'Something went wrong';
                      if (e.code == 'user-not-found') {
                        message = 'No user found for that email';
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
