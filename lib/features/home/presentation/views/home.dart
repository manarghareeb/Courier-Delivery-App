import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/features/couriers/presentation/views/couriers_screen.dart';
import 'package:courier_delivery_app/features/deliveries/presentation/views/deliveries_screen.dart';
import 'package:courier_delivery_app/features/home/presentation/views/home_screen.dart';
import 'package:courier_delivery_app/features/packages/presentation/views/packages_screen.dart';
import 'package:courier_delivery_app/features/account/presentation/views/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> {
  int index = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const PackagesScreen(),
    const DeliveriesScreen(),
    const CouriersScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        backgroundColor: Colors.white,
        selectedItemColor: ColorManager.mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, size: 21.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.boxesPacking, size: 21.sp),
            label: 'Packages',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.truck, size: 21.sp),
            label: 'Deliveries',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.personRunning, size: 21.sp),
            label: 'Couriers',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser, size: 21.sp),
            label: 'Profile',
          ),
        ],
      ),
      body: screens[index],
    );
  }
}
