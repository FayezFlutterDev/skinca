import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinca/views/auth/auth_cubit/user_state.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/icon_borken.dart';
import '../auth_cubit/user_cubit.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = '/forget_password';
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.green,
          );
          Navigator.pushNamed(context, '/verification_code');
        } else if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2, size: 36),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenHeight * 0.02),
              child: Form(
                key: context.read<UserCubit>().forgotFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Forgot your password?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      const Text(
                        "Enter your email or your phone number, we will send you confirmation code",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Center(
                        child: Container(
                          width: SizeConfig.screenWidth * 0.86,
                          height: SizeConfig.screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(children: [
                            GestureDetector(
                              onTap: () {
                                context.read<UserCubit>().toggleMail();
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(5),
                                  width: SizeConfig.screenWidth * 0.4,
                                  height: SizeConfig.screenHeight * 0.07,
                                  decoration: BoxDecoration(
                                    color:
                                        context.read<UserCubit>().isMailSelected
                                            ? Colors.white
                                            : const Color(0xFFE5E7EB),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: context
                                                .read<UserCubit>()
                                                .isMailSelected
                                            ? AppColors.primary
                                            : Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<UserCubit>().toggleMail();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                width: SizeConfig.screenWidth * 0.4,
                                height: SizeConfig.screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  color:
                                      context.read<UserCubit>().isMailSelected
                                          ? const Color(0xFFE5E7EB)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'Phone',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: context
                                              .read<UserCubit>()
                                              .isMailSelected
                                          ? Colors.grey
                                          : AppColors.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      context.read<UserCubit>().isMailSelected
                          ? buildEmailTextFormField(context)
                          : buildPhoneTextFormField(context),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      if(state is ForgotPasswordLoading)
                        const Center(child: CircularProgressIndicator(),)
                      else
                      DefaultButton(
                          text: 'Reset Password',
                          press: () {
                            if (context
                                .read<UserCubit>()
                                .forgotFormKey
                                .currentState!
                                .validate()) {
                              context.read<UserCubit>().forgotPassword();
                            }
                          }),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField buildEmailTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().forgotemailController,
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

  TextFormField buildPhoneTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().forgotPhoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPhoneNumberNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Calling,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Enter your phone number",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
