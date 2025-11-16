import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:courier_delivery_app/core/theming/colors.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';

class PackageListWidget extends StatelessWidget {
  final List<DeliveryModel> packages;
  final String filter;
  final Function(DeliveryModel) onPackageTap;

  const PackageListWidget({
    super.key,
    required this.packages,
    required this.filter,
    required this.onPackageTap,
  });

  @override
  Widget build(BuildContext context) {
    List<DeliveryModel> filtered = [];
    if (filter == 'All') {
      filtered = packages;
    } else {
      filtered = packages
        .where((p) => p.status.toLowerCase() == filter.toLowerCase())
        .toList();
    }

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          'No $filter packages found',
          style: TextStyles.font14GreyNormalItalic,
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, i) {
        final package = filtered[i];
        return Card(
          color: ColorManager.textFieldColor,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: ListTile(
            title: Text(
              package.id,
              style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              'Price: ${package.totalPrice} | Status: ${package.status}',
              style: TextStyles.font14GreyNormalItalic,
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
            onTap: () => onPackageTap(package),
          ),
        );
      },
    );
  }
}
