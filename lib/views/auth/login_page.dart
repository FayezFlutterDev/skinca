import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/core/components/default_button.dart';
import 'package:skinca/core/components/verified_dialog.dart';
import 'package:skinca/core/constants/app_colors.dart';
import 'package:skinca/views/auth/auth_cubit/user_cubit.dart';
import 'package:skinca/views/auth/auth_cubit/user_state.dart';
import 'package:skinca/views/auth/forget_password/forget_password.dart';
import 'package:skinca/views/auth/sign_up/sign_up_page.dart';
import 'package:skinca/views/entrypoint/entrypoint_ui.dart';

import '../../core/components/divider.dart';
import '../../core/components/social_card.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/icon_borken.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess &&
            context.read<UserCubit>().user?.isAuthenticated == true) {
          showGeneralDialog(
            barrierLabel: 'Dialog',
            barrierDismissible: true,
            context: context,
            pageBuilder: (ctx, anim1, anim2) => VerifiedDialog(
              text: 'Yeay! 🎉\n Welcome Back',
              text2: context.read<UserCubit>().user!.message,
              text3: 'Go to Home',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, EntryPointUI.routeName, (route) => false);
              },
            ),
            transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
              scale: anim1,
              child: child,
            ),
          );
        } else if (state is SignInFailure) {
          showGeneralDialog(
            barrierLabel: 'Dialog',
            barrierDismissible: true,
            context: context,
            pageBuilder: (ctx, anim1, anim2) => VerifiedDialog(
              isVerified: false,
              text: 'Oops! 😢',
              text2: state.message,
              text3: 'Try Again',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
              scale: anim1,
              child: child,
            ),
          );
        }
      },
      builder: (context, state) {
        
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                size: 36,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Login',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: SafeArea(
                child: Form(
                  key: context.read<UserCubit>().signInFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      buildEmailTextFormField(context),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      buildPasswordTextFormField(context),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: context.read<UserCubit>().agree,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              context.read<UserCubit>().toggleAgree(value!);
                            },
                          ),
                          const Text("Remember me"),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ForgetPassword.routeName),
                            child: const Text(
                              "Forgot Password!",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                  fontSize: 18,
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      if (state is SignInLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                      DefaultButton(
                          text: "Login",
                          press: () {
                            if (context
                                .read<UserCubit>()
                                .signInFormKey
                                .currentState!
                                .validate()) {
                              context.read<UserCubit>().signIn();
                            }
                          }),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      const Text("If you don't have an existing account,",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, SignUpPage.routeName),
                        child: const Text(
                          "Sign Up",
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      const MyDivider(),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      const SocialCard(
                          image: "assets/images/google.png",
                          text: "Sign in  with Google"),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const SocialCard(
                        image: "assets/images/facebook.png",
                        text: "Sign in  with Facebook",
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      const SocialCard(
                        image: "assets/images/TwitterX.png",
                        text: "Sign in  with Twitter X",
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

  TextFormField buildEmailTextFormField(BuildContext context) {
    return TextFormField(
      controller: BlocProvider.of<UserCubit>(context).signInEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Message,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Enter your email",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildPasswordTextFormField(BuildContext context) {
    return TextFormField(
      controller: BlocProvider.of<UserCubit>(context).signInPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !context.read<UserCubit>().visiblePass,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value.length < 7) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Password,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Password",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
        suffixIcon: IconButton(
          onPressed: () {
            context.read<UserCubit>().toggleVisiblePass();
          },
          icon: context.read<UserCubit>().visiblePass
              ? const Icon(
                  Icons.visibility,
                  size: 28,
                  color: AppColors.primary,
                )
              : const Icon(
                  Icons.visibility_off,
                  size: 28,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}
