import 'package:courier_delivery_app/core/routing/app_router.dart';
import 'package:courier_delivery_app/core/theming/styles.dart';
import 'package:courier_delivery_app/core/widgets/custom_button_widget.dart';
import 'package:courier_delivery_app/core/widgets/custom_text_field_widget.dart';
import 'package:courier_delivery_app/features/authentication/cubit/auth_state.dart';
import 'package:courier_delivery_app/features/authentication/cubit/signup_cubit.dart';
import 'package:courier_delivery_app/features/authentication/presentation/widgets/already_have_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> nameformKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailformKey = GlobalKey<FormState>();
  GlobalKey<FormState> passformKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        if (state is SignUpSuccess) {
          GoRouter.of(context).push(AppRouter.loginScreen);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
      inAsyncCall: state is SignUpLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            child: SingleChildScrollView(
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
                  SizedBox(height: 40.h),
                  Text(
                    'Let\'s get started',
                    style: TextStyles.font20BlackBoldItalic.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Please input your details',
                    style: TextStyles.font12GreyNormalItalic,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFieldWidget(
                    formKey: nameformKey,
                    controller: nameController,
                    hintText: 'Enter your Full Name',
                    textInputType: TextInputType.name,
                    title: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your full name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFieldWidget(
                    formKey: emailformKey,
                    controller: emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    title: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      } else if (value.contains("@gmail.com") == false) {
                        return 'this email is not valid "missing @gmail.com"';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextFieldWidget(
                    formKey: phoneformKey,
                    controller: phoneController,
                    hintText: 'Enter youe phone Number',
                    textInputType: TextInputType.phone,
                    title: 'Phone Number',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number";
                      } else if (value.length != 11) {
                        return "Phone number must be 11 digits";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
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
                  SizedBox(height: 30.h),
                  CustomButtonWidget(
                    buttonText: 'SignUp',
                    onPressed: () {
                      if (nameformKey.currentState!.validate() &&
                          emailformKey.currentState!.validate() &&
                          passformKey.currentState!.validate() &&
                          phoneformKey.currentState!.validate()) {
                            final signupCubit = context.read<SignupCubit>();
                            signupCubit.name.text = nameController.text;
                            signupCubit.email.text = emailController.text;
                            signupCubit.password.text = passwordController.text;
                            signupCubit.phone.text = phoneController.text;
                            signupCubit.signupAccount();
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  const AlreadyHaveAccount(),
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
