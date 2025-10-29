import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:courier_delivery_app/features/authentication/cubit/auth_state.dart';
import 'package:courier_delivery_app/features/authentication/cubit/login_cubit.dart';
import 'package:courier_delivery_app/features/authentication/presentation/widgets/create_new_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> emailformKey = GlobalKey<FormState>();
  GlobalKey<FormState> passformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        if (state is LoginSuccess) {
          GoRouter.of(context).push(AppRouter.homeView);  
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Packers & Movers',
                          style: TextStyles.font32MainColorBold,
                        ),
                      ),
                      SizedBox(height: 70.h),
                      Text(
                        'Welcome',
                        style: TextStyles.font20BlackBoldItalic.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Please input your details',
                        style: TextStyles.font12GreyNormalItalic,
                      ),
                      SizedBox(height: 50.h),
                      CustomTextFieldWidget(
                        formKey: emailformKey,
                        controller: emailOrPhoneController,
                        hintText: 'Enter your email',
                        textInputType: TextInputType.emailAddress,
                        title: 'Email or phone Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          } else if (value.contains("@gmail.com") == false) {
                            return 'this email is not valid "missing @gmail.com"';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextFieldWidget(
                        formKey: passformKey,
                        controller: passwordController,
                        hintText: 'Enter your password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        title: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomButtonWidget(
                        buttonText: 'Login',
                        onPressed: () {
                          if (emailformKey.currentState!.validate() &&
                              passformKey.currentState!.validate()) {
                            final loginCubit = context.read<LoginCubit>();
                            loginCubit.email.text = emailOrPhoneController.text.trim();
                            loginCubit.password.text = passwordController.text.trim();
                            loginCubit.loginAccount();
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      const CreateNewAccount(),
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
