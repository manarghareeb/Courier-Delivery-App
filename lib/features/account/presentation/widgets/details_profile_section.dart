import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/account/presentation/widgets/onpressed_edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProfileSection extends StatefulWidget {
  const DetailsProfileSection({super.key});

  @override
  State<DetailsProfileSection> createState() => _DetailsProfileSectionState();
}

class _DetailsProfileSectionState extends State<DetailsProfileSection> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email: ${CacheHelper.getData('email')}',
              style: TextStyles.font12GreyNormalItalic,
            ),
            Text(
              'Phone: ${CacheHelper.getData('phone')}',
              style: TextStyles.font12GreyNormalItalic,
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                (context) => OnPressedOnEditProfile(
                  nameController: nameController, 
                  nameKey: nameKey, 
                  emailController: emailController, 
                  emailKey: emailKey, 
                  phoneController: phoneController, 
                  phoneKey: phoneKey
                ),
            );
          },
          label: const Text('Edit Profile'),
          style: TextButton.styleFrom(
            backgroundColor: ColorManager.mainColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            textStyle: TextStyles.font10BlackW700Italic,
            minimumSize: Size(80.w, 30.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          ),
        ),
      ],
    );
  }
}

