import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/features/onboarding/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              focal: Alignment(-0.5, 0.5),
              tileMode: TileMode.clamp,
              radius: (1.2).r,
              colors: [ColorManager.red, ColorManager.mainColor],
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Logo(),
                  SizedBox(height: 30.h),
                  Text(
                    'Packers & Movers',
                    style: TextStyles.font32MainColorBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 25.w),
                    child: Text(
                      'On-demand delivery whenever and wherever the need arises.',
                      style: TextStyles.font14WhiteNormal,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  CustomButtonWidget(
                    buttonText: 'Get Started',
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.loginScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
