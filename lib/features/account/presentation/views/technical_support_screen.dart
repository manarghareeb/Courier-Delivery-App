import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/alert_dialog_widget.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/features/account/cubit/technical_support_cubit/technical_support_cubit.dart';
import 'package:courier_delivery_app/features/account/cubit/technical_support_cubit/technical_support_state.dart';
import 'package:courier_delivery_app/features/account/data/technical_support_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return BlocConsumer<TechnicalSupportCubit, TechnicalSupportState>(
      listener: (context, state) {
        if (state is TechnicalSupportError) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialogWidget(
                  title: state.message,
                  onPressedYes: () {
                    Navigator.of(context).pop();
                  },
                ),
          );
        }
        if (state is TechnicalSupportSuccess) {
          GoRouter.of(context).push(AppRouter.homeScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Technical Support'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How can we help you?',
                  style: TextStyles.font20BlackBoldItalic.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  controller: messageController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Describe your issue here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButtonWidget(
                  buttonText: 'Send Message',
                  onPressed: () {
                    final messageText = messageController.text.trim();
                    if (messageText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a message'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId == null) return;
                    final supportMessage = TechnicalSupportModel(
                      userId: userId,
                      id: '',
                      message: messageText,
                    );
                    context.read<TechnicalSupportCubit>().addSupportMessage(
                      supportMessage,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Message sent!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
