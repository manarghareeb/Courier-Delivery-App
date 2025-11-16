import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/services/api_keys.dart';
import 'package:courier_delivery_app/features/account/cubit/technical_support_cubit/technical_support_cubit.dart';
import 'package:courier_delivery_app/features/authentication/cubit/login_cubit.dart';
import 'package:courier_delivery_app/features/authentication/cubit/signup_cubit.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_cubit.dart';
import 'package:courier_delivery_app/features/deliveries/cubit/delivery_cubit.dart';
import 'package:courier_delivery_app/features/notifications/cubit/notification_cubit.dart';
import 'package:courier_delivery_app/features/packages/cubit/package_cubit.dart';
import 'package:courier_delivery_app/features/payments/data/manager/cubit/stripe_payment_cubit.dart';
import 'package:courier_delivery_app/features/payments/data/repos/payment_repo_impl.dart';
import 'package:courier_delivery_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => DeliveryCubit()),
        BlocProvider(create: (context) => PackageCubit()),
        BlocProvider(create: (context) => CourierCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => TechnicalSupportCubit()),
        BlocProvider(
            create: (context) => StripePaymentCubit(PaymentRepoImpl())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.route,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
