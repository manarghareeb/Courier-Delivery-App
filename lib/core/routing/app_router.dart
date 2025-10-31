import 'package:courier_delivery_app/features/account/presentation/views/payment_screen.dart';
import 'package:courier_delivery_app/features/account/presentation/views/technical_support_screen.dart';
import 'package:courier_delivery_app/features/account/presentation/views/terms_conditions_screen.dart';
import 'package:courier_delivery_app/features/authentication/cubit/login_cubit.dart';
import 'package:courier_delivery_app/features/authentication/cubit/signup_cubit.dart';
import 'package:courier_delivery_app/features/authentication/presentation/views/forget_password_screen.dart';
import 'package:courier_delivery_app/features/home/presentation/views/home.dart';
import 'package:courier_delivery_app/features/home/presentation/views/home_screen.dart';
import 'package:courier_delivery_app/features/authentication/presentation/views/login_screen.dart';
import 'package:courier_delivery_app/features/authentication/presentation/views/signup_screen.dart';
import 'package:courier_delivery_app/features/notifications/notifications_screen.dart';
import 'package:courier_delivery_app/features/account/presentation/views/account_screen.dart';
import 'package:courier_delivery_app/features/onboarding/onboarding_screen.dart';
import 'package:courier_delivery_app/features/packages/presentation/views/packages_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final loginScreen = '/loginScreen';
  static final signUpScreen = '/signupScreen';
  static final homeScreen = '/homeScreen';
  static final homeView = '/homeView';
  static final notificationsScreen = '/notificationsScreen';
  static final accountScreen = '/accountScreen';
  static final paymentMethodsScreen = '/paymentMethodsScreen';
  static final technicalSupportScreen = '/technicalSupportScreen';
  static final termsAndConditionsScreen = '/termsAndConditionsScreen';
  static final packagesScreen = '/packagesScreen';
  static final forgetPasswordScreen = '/forgetPasswordScreen';

  static final route = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
      GoRoute(
        path: loginScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: BlocProvider.of<LoginCubit>(context),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        path: signUpScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: BlocProvider.of<SignupCubit>(context),
              child: SignUpScreen(),
            ),
      ),
      GoRoute(
        path: forgetPasswordScreen,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: homeView,
        name: AppRouter.homeView,
        builder: (context, state) {
          final index = state.extra as int? ?? 0;
          return HomeView(initialIndex: index);
        },
        //builder: (context, state) => HomeView()
      ),
      GoRoute(
        path: notificationsScreen,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: accountScreen,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: paymentMethodsScreen,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: technicalSupportScreen,
        builder: (context, state) => const TechnicalSupportScreen(),
      ),
      GoRoute(
        path: termsAndConditionsScreen,
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),
      GoRoute(
        path: packagesScreen,
        builder: (context, state) => const PackagesScreen(),
      ),
    ],
  );
}

/*GoRoute(
        path: courierDetailScreen,
        builder: (context, state) {
          final courier = state.extra as Map<String, dynamic>?;
          if (courier == null) {
            return Scaffold(
              body: Center(child: Text('Courier data not found')),
            );
          }
          return CourierDetailScreen(courier: courier);
        },
      ),*/
