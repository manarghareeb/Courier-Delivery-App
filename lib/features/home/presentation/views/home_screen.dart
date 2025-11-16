import 'package:courier_delivery_app/features/home/presentation/widgets/ads_banner_section.dart';
import 'package:courier_delivery_app/features/home/presentation/widgets/name_notifications_section.dart';
import 'package:courier_delivery_app/features/home/presentation/widgets/order_progress_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                const NameNotificationsSection(),
                SizedBox(height: 20.h),
                const AdsBannerSection(),
                SizedBox(height: 20.h),
                const OrderProgressSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
