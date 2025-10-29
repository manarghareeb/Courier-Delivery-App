import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/small_text_button_widget.dart';
import 'package:flutter/material.dart';

class YesAndCancelInAlertDialog extends StatelessWidget {
  const YesAndCancelInAlertDialog({
    super.key,
    required this.onPressedYes,
  });

  final VoidCallback onPressedYes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SmallTextButtomWidget(title: 'Yes', onPressed: onPressedYes),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: ColorManager.mainColor,
              ),
            ),
            minimumSize: const Size(100, 40)
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyles.font14GreyNormalItalic.copyWith(
              color: ColorManager.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
