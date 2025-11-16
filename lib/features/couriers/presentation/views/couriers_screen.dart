import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/couriers/presentation/views/courier_details_screen.dart';
import 'package:courier_delivery_app/features/packages/cubit/package_cubit.dart';
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
            BlocConsumer<PackageCubit, PackageState>(
              listener: (context, state) {
                if (state is PackageError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is PackageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PackageSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.packages.length,
                      itemBuilder: (context, index) {
                        final package = state.packages[index];
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
                              package.id,
                              style: TextStyles.font16WhiteW600.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        CourierDetailScreen(package: package)),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No Coureirs found.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
