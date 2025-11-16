import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/yes_cancel_alert_dialog.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.onPressedYes,
  });

  final String title;
  final VoidCallback onPressedYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyles.font20BlackBoldItalic,
        textAlign: TextAlign.center,
      ),
      content: Card(elevation: 8),
      actions: [
        YesAndCancelInAlertDialog(onPressedYes: onPressedYes),
      ],
    );
  }
}
