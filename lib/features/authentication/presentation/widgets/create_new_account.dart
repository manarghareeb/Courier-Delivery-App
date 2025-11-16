import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Need a account?',
          style: TextStyles.font14WhiteNormal.copyWith(
              color: ColorManager.geyColor, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.signUpScreen);
          },
          child: Text(
            'Sign Up',
            style: TextStyles.font14WhiteNormal.copyWith(
                color: ColorManager.mainColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
