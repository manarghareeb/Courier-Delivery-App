import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:flutter/material.dart';

class AccountTileWidget extends StatelessWidget {
  const AccountTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.grey),
      title: Text(
        title,
        style: TextStyles.font16WhiteW600.copyWith(
          color: ColorManager.lightBlueColor.withOpacity(0.8),
        ),
      ),
      onTap: onTap,
    );
  }
}
