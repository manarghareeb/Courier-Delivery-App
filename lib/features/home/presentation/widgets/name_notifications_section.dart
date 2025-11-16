import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NameNotificationsSection extends StatelessWidget {
  const NameNotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome 👋',
              style: TextStyles.font12BlackBoldNormal.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '${CacheHelper.getData('name')}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.notificationsScreen);
          }
        ),
      ],
    );
  }
}
