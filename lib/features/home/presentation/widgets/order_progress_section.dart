import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/packages/cubit/package_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class OrderProgressSection extends StatefulWidget {
  const OrderProgressSection({super.key});

  @override
  State<OrderProgressSection> createState() => _OrderProgressSectionState();
}

class _OrderProgressSectionState extends State<OrderProgressSection> {
  @override
  void initState() {
    super.initState();
    context.read<PackageCubit>().fetchPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageCubit, PackageState>(
      listener: (context, state) async {
        if (state is PackageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is PackageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PackageSuccess) {
          final inProgressDeliveries = state.packages
              .where(
                (delivery) =>
                    delivery.status.toLowerCase().trim() == 'in progress',
              )
              .toList();
          if (inProgressDeliveries.isEmpty) {
            return const Center(child: Text('No Order Progress found.'));
          }
          return Container(
            decoration: BoxDecoration(
              color: ColorManager.textFieldColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inProgressDeliveries.length,
              itemBuilder: (context, index) {
                final delivery = inProgressDeliveries[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                    top: 3.h,
                    bottom: 12.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order Progress',
                            style: TextStyles.font12BlackBoldNormal,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).push(AppRouter.mapScreen);
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ORDID: ${delivery.id}',
                                  style: TextStyles.font14WhiteNormal.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rider: Ahmed Ali',
                                  style: TextStyles.font12GreyNormalItalic,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              'In Progress',
                              style: TextStyles.font10BlackW700Italic.copyWith(
                                color: Colors.amber,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.truck,
                              color: ColorManager.mainColor,
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: const Color.fromARGB(
                                        255,
                                        35,
                                        139,
                                        39,
                                      ),
                                      size: 15,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'Drop off',
                                      style: TextStyles.font10BlackW700Italic,
                                    ),
                                  ],
                                ),
                                Text(
                                  delivery.dropOffLocation,
                                  style: TextStyles.font12BlackBoldNormal,
                                ),
                                Text(
                                  '20 mins to delivery location',
                                  style: TextStyles.font10BlackW700Italic,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
