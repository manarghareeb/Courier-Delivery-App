import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/alert_dialog_widget.dart';
import 'package:courier_delivery_app/features/notifications/cubit/notification_cubit.dart';
import 'package:courier_delivery_app/features/notifications/cubit/notification_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final cubit = context.read<NotificationCubit>();
    cubit.fetchNotifications(userId);
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialogWidget(
              title: state.message,
              onPressedYes: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is NotificationLoding) {
          return const Center(child: CircularProgressIndicator());
        }
        final notifications =
            state is NotificationSuccess ? state.notifications : [];
        return Scaffold(
          appBar: AppBar(
            title: Text('Notifications'),
            centerTitle: true,
          ),
          body: notifications.isEmpty
              ? const Center(child: Text('No notifications yet.'))
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return Card(
                      color: ColorManager.textFieldColor,
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      child: ListTile(
                        title: Text(
                          notif.title,
                          style: TextStyles.font20BlackBoldItalic
                              .copyWith(fontStyle: FontStyle.normal),
                        ),
                        subtitle: Text(
                          notif.body,
                          style: TextStyles.font14GreyNormalItalic,
                        ),
                        trailing: Text(
                          notif.createdAt.toDate().toString().substring(0, 16),
                          style: TextStyles.font12GreyNormalItalic,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
