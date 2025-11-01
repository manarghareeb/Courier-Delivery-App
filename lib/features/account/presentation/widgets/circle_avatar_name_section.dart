import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/account/presentation/widgets/details_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAvatarAndNameSection extends StatefulWidget {
  const CircleAvatarAndNameSection({
    super.key,
  });

  @override
  State<CircleAvatarAndNameSection> createState() => _CircleAvatarAndNameSectionState();
}

class _CircleAvatarAndNameSectionState extends State<CircleAvatarAndNameSection> {
  @override
  Widget build(BuildContext context) {

    String getInitials(String name) {
      final parts = name.trim().split(' ');
      if (parts.length > 1) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      } else {
        return parts[0][0].toUpperCase();
      }
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: ColorManager.mainColor,
          child: Text(
            getInitials(CacheHelper.getData('name')),
            style: TextStyles.font32MainColorBold.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          CacheHelper.getData('name'),
          style: TextStyles.font20BlackBoldItalic.copyWith(
            fontStyle: FontStyle.normal,
          ),
        ),
        SizedBox(height: 20.h),
        DetailsProfileSection(
          onProfileUpdated: (){
            setState(() {
              
            });
          },
        ),
      ],
    );
  }
}

