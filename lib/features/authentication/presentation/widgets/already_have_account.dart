import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have a account?', 
          style: TextStyles.font14WhiteNormal.copyWith(
            color: ColorManager.geyColor,
            fontWeight: FontWeight.w600
          ),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.loginScreen);
          },
          child: Text(
            'Login',
            style: TextStyles.font14WhiteNormal.copyWith(
              color: ColorManager.mainColor,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ],
    );
  }
}