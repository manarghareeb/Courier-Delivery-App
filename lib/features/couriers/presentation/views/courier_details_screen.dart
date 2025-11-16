import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/small_text_button_widget.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_cubit.dart';
import 'package:courier_delivery_app/features/deliveries/cubit/delivery_cubit.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CourierDetailScreen extends StatefulWidget {
  const CourierDetailScreen({super.key, required this.package});
  final DeliveryModel package;

  @override
  State<CourierDetailScreen> createState() => _CourierDetailScreenState();
}

class _CourierDetailScreenState extends State<CourierDetailScreen> {
  double userRating = 0;
  final double estimatedTime = 45;
  final double price = 100;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        if (state is DeliveryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is DeliveryLoading,
          child: Scaffold(
                appBar: AppBar(title: Text('Delivery ID: ${widget.package.id}')),
                body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Package Info',
                style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                '- Weight: ${widget.package.packageInfo.weight}',
                style: TextStyles.font14GreyNormalItalic,
              ),
              Text(
                '- Size: ${widget.package.packageInfo.size}',
                style: TextStyles.font14GreyNormalItalic,
              ),
              Text(
                '- Contents: ${widget.package.packageInfo.contents}',
                style: TextStyles.font14GreyNormalItalic,
              ),
              SizedBox(height: 16.h),
              Text(
                'From / To Locations',
                style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                'From: ${widget.package.pickupLocation}',
                style: TextStyles.font14GreyNormalItalic,
              ),
              Text(
                'To: ${widget.package.dropOffLocation}',
                style: TextStyles.font14GreyNormalItalic,
              ),
              SizedBox(height: 16.h),
              Text(
                'Estimated Time & Price',
                style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                'Time: $estimatedTime mins\nPrice: $price EGP',
                style: TextStyles.font14GreyNormalItalic,
              ),
              SizedBox(height: 20.h,),
              Text(
                'Rate this courier:',
                style: TextStyles.font16WhiteW600.copyWith(color: Colors.black),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      index < userRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        userRating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 16.h),
              Center(
                child: SmallTextButtomWidget(
                  title: 'Submit Rating', 
                  onPressed: () {
                    if (userRating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a rating before submitting')),
                      );
                      return;
                    }
                    final courierCubit = context.read<CourierCubit>();
                    courierCubit.addCourier(
                      deliveryId: widget.package.id,
                      rating: userRating,
                      estimatedTime: estimatedTime,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rating saved successfully!')),
                    );
                  },
                ),
              ),
            ],
          ),
                ),
              ),
        );
      },
    );
  }
}
