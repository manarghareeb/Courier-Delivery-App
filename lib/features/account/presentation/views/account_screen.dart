import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/widgets/alert_dialog_widget.dart';
import 'package:courier_delivery_app/features/account/presentation/widgets/circle_avatar_name_section.dart';
import 'package:courier_delivery_app/features/account/presentation/widgets/account_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              Center(child: CircleAvatarAndNameSection()),
              SizedBox(height: 10.h),
              const Divider(),
              SizedBox(height: 10.h),
              AccountTileWidget(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.paymentMethodsScreen);
                },
              ),
              AccountTileWidget(
                icon: Icons.support_agent_outlined,
                title: 'Technical Support',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.technicalSupportScreen);
                },
              ),
              AccountTileWidget(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.termsAndConditionsScreen);
                },
              ),
              SizedBox(height: 10.h),
              const Divider(),
              SizedBox(height: 10.h),
              AccountTileWidget(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                iconColor: ColorManager.mainColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialogWidget(
                          title: 'Are you sure to delete your account?',
                          onPressedYes: () async {
                            try {
                              User? user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final userId = user.uid;
                                await FirebaseFirestore.instance.collection('users').doc(userId).delete();
                                await user.delete();
                                await CacheHelper.clearData();
                                GoRouter.of(context).go(AppRouter.signUpScreen);
                              }
                            } catch (e) {
                              print('Error deleting account: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error deleting account: $e'),
                                ),
                              );
                            }
                          },
                        ),
                  );
                },
              ),
              AccountTileWidget(
                icon: Icons.logout,
                title: 'Logout',
                iconColor: ColorManager.mainColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialogWidget(
                          title: 'Are you sure to logout?',
                          onPressedYes: () async {
                            await FirebaseAuth.instance.signOut();
                            await CacheHelper.clearData();
                            GoRouter.of(context).go(AppRouter.loginScreen);
                          },
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
