import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/core/widgets/alert_dialog_widget.dart';
import 'package:courier_delivery_app/features/deliveries/cubit/delivery_cubit.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:courier_delivery_app/features/deliveries/data/package_info.dart';
import 'package:courier_delivery_app/features/deliveries/data/receiver_info.dart';
import 'package:courier_delivery_app/features/deliveries/presentation/widgets/address_text_field.dart';
import 'package:courier_delivery_app/features/deliveries/presentation/widgets/drop_down_button_widget.dart';
import 'package:courier_delivery_app/features/deliveries/presentation/widgets/package_info_section.dart';
import 'package:courier_delivery_app/features/deliveries/presentation/widgets/receiver_info_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({super.key});

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  TextEditingController weightController = TextEditingController();
  final weightKey = GlobalKey<FormState>();
  TextEditingController sizeController = TextEditingController();
  final sizeKey = GlobalKey<FormState>();
  TextEditingController contentsController = TextEditingController();
  final contentsKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  final nameKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  final phoneKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  final addressKey = GlobalKey<FormState>();
  TextEditingController locationController = TextEditingController();
  final locationKey = GlobalKey<FormState>();

  final TextEditingController pickupLocationController = TextEditingController();
  final TextEditingController dropOffLocationController = TextEditingController();
  final pickupLocationKey = GlobalKey<FormState>();
  final dropOffLocationKey = GlobalKey<FormState>();

  @override
  void dispose() {
    weightController.dispose();
    sizeController.dispose();
    contentsController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    locationController.dispose();
    pickupLocationController.dispose();
    dropOffLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCubit, DeliveryState>(
      listener: (context, state) {
        if (state is DeliveryError) {
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
        if (state is DeliverySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Delivery operation successful'),
              backgroundColor: Colors.green,
            ),
          );
          GoRouter.of(context).push(AppRouter.homeView, extra: 1);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is DeliveryLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Create Deliveries',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup & Dropoff Info',
                        style: TextStyles.font14GreyNormalItalic,
                      ),
                      SizedBox(height: 10.h),
                      AddressTextField(
                        controller: pickupLocationController,
                        hintText: 'Pickup Location',
                        title: 'Pickup Location',
                        formKey: pickupLocationKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pickup location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      AddressTextField(
                        controller: dropOffLocationController,
                        hintText: 'Drop-off Location',
                        title: 'Drop-off Location',
                        formKey: dropOffLocationKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter drop-off location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Packages Info',
                        style: TextStyles.font14GreyNormalItalic,
                      ),
                      SizedBox(height: 10.h),
                      PackageInfoSection(
                        weightController: weightController,
                        weightKey: weightKey,
                        sizeController: sizeController,
                        sizeKey: sizeKey,
                        contentsController: contentsController,
                        contentsKey: contentsKey,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Receiver Info',
                        style: TextStyles.font14GreyNormalItalic,
                      ),
                      SizedBox(height: 10.h),
                      ReceiverInfoSection(
                        nameController: nameController,
                        nameKey: nameKey,
                        phoneController: phoneController,
                        phoneKey: phoneKey,
                        addressController: addressController,
                        addressKey: addressKey,
                        locationController: locationController,
                        locationKey: locationKey,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Delivery Type',
                        style: TextStyles.font14GreyNormalItalic,
                      ),
                      SizedBox(height: 10.h),
                      DropDownButtonWidget(
                        hintText: 'Select Delivery Type',
                        types: ['Standard', 'Express', 'Same Day'],
                        onChange: (value) {
                          context.read<DeliveryCubit>().setDeliveryType(value!);
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Payment Method',
                        style: TextStyles.font14GreyNormalItalic,
                      ),
                      SizedBox(height: 10.h),
                      DropDownButtonWidget(
                        hintText: 'Select Payment Method',
                        types: ['Cash', 'Card', 'Online'],
                        onChange: (value) {
                          context.read<DeliveryCubit>().setPaymentMethod(
                            value!,
                          );
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomButtonWidget(
                        buttonText: 'Comfirm',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogWidget(
                                title: 'Are you sure for delivery?',
                                onPressedYes: () {
                                  Navigator.of(context).pop();
                                  if (weightKey.currentState!.validate() &&
                                      sizeKey.currentState!.validate() &&
                                      contentsKey.currentState!.validate() &&
                                      nameKey.currentState!.validate() &&
                                      phoneKey.currentState!.validate() &&
                                      addressKey.currentState!.validate() &&
                                      locationKey.currentState!.validate() &&
                                      pickupLocationKey.currentState!
                                          .validate() &&
                                      dropOffLocationKey.currentState!
                                          .validate()) {
                                    final deliveryCubit =
                                        context.read<DeliveryCubit>();
                                    final newDelivery = DeliveryModel(
                                      id: '',
                                      packageInfo: PackageInfo(
                                        weight: weightController.text.trim(),
                                        size: sizeController.text.trim(),
                                        contents:
                                            contentsController.text.trim(),
                                      ),
                                      receiverInfo: ReceiverInfo(
                                        name: nameController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        address: addressController.text.trim(),
                                        location:
                                            locationController.text.trim(),
                                      ),
                                      deliveryType:
                                          deliveryCubit.deliveryType ??
                                          'Standard',
                                      paymentMethod:
                                          deliveryCubit.paymentMethod ?? 'Cash',
                                      pickupLocation:
                                          pickupLocationController.text.trim(),
                                      dropOffLocation:
                                          dropOffLocationController.text.trim(),
                                      totalPrice:
                                          deliveryCubit.deliveryType ==
                                                  'Express'
                                              ? 20.0
                                              : 10.0,
                                      courierId: '',
                                      status: 'pending',
                                      userId:
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                      createdAt: null,
                                    );
                                    deliveryCubit.addDelivery(newDelivery);
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

