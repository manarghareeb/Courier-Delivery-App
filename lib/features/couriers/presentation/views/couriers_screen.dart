import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_cubit.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_state.dart';
import 'package:courier_delivery_app/features/couriers/presentation/views/courier_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouriersScreen extends StatefulWidget {
  const CouriersScreen({super.key});

  @override
  State<CouriersScreen> createState() => _CouriersScreenState();
}

class _CouriersScreenState extends State<CouriersScreen> {
  final List<Map<String, dynamic>> featuredCouriers = const [
    {'name': 'Ali Hassen', 'rating': 4.5},
    {'name': 'Mohamed Saad', 'rating': 4.2},
    {'name': 'Yousef Ahmed', 'rating': 4.8},
    {'name': 'Ahmed Mahmoud', 'rating': 3.0},
    {'name': 'Omar Mostafa', 'rating': 3.2},
    {'name': 'Salah Ibrahim', 'rating': 1.8},
  ];

  /*final List<Map<String, dynamic>> couriers = const [
    {'name': 'Ali Express', 'status': 'Available'},
    {'name': 'FastGo', 'status': 'Busy'},
    {'name': 'Speedy', 'status': 'Available'},
    {'name': 'QuickShip', 'status': 'Available'},
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search couriers...',
                        filled: true,
                        fillColor: ColorManager.textFieldColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                  IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
                ],
              ),
            ),
            SizedBox(
              height: 120.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredCouriers.length,
                itemBuilder: (context, index) {
                  final courier = featuredCouriers[index];
                  return Container(
                    width: 150,
                    margin: EdgeInsets.all(8.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: ColorManager.lightBlueColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          courier['name'],
                          style: TextStyles.font16WhiteW600,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              courier['rating'].toString(),
                              style: TextStyles.font14WhiteNormal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: BlocConsumer<CourierCubit, CourierState>(
                listener: (context, state) {
                  if (state is CourierError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is CourierLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CourierSuccess) {
                    final couriers = state.couriers;
                    return ListView.builder(
                      itemCount: couriers.length,
                      itemBuilder: (context, index) {
                        final courier = couriers[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ListTile(
                            tileColor: ColorManager.textFieldColor,
                            title: Text(
                              courier.name,
                              style: TextStyles.font16WhiteW600.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Status: ${courier.status}',
                              style: TextStyles.font14GreyNormalItalic,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          CourierDetailScreen(courier: courier),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No couriers found.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
