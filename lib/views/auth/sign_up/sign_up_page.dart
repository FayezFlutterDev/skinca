import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinca/core/components/verified_dialog.dart';
import 'package:skinca/core/utils/keyboard.dart';
import 'package:skinca/views/auth/auth_cubit/user_cubit.dart';
import 'package:skinca/views/auth/auth_cubit/user_state.dart';
import 'package:skinca/views/auth/login_page.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/icon_borken.dart';
import 'privacy.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess &&
            context.read<UserCubit>().registerResponse?.isAuthenticated ==
                true) {
          showGeneralDialog(
            barrierLabel: 'Dialog',
            barrierDismissible: true,
            context: context,
            pageBuilder: (ctx, anim1, anim2) => VerifiedDialog(
              text: 'Yeay! 🎉\n Successfully Registered',
              text2: context.read<UserCubit>().registerResponse!.message,
              text3: 'Login Now',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              },
            ),
            transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
              scale: anim1,
              child: child,
            ),
          );
        } else if (state is SignUpFailure) {
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
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
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: context.read<UserCubit>().registerFormKey,
                child: Column(
                  children: [
                    context.read<UserCubit>().profilePic == null
                        ? Stack(children: [
                            CircleAvatar(
                              radius: getProportionateScreenWidth(35),
                              backgroundImage:
                                  const AssetImage("assets/images/avatar.png"),
                            ),
                            Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade400,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery)
                                          .then((value) {
                                        if (value != null) {
                                          context
                                              .read<UserCubit>()
                                              .uploadProfilePic(value);
                                        }
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      radius: 5,
                                      child: const Icon(
                                        Icons.camera_alt_sharp,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ))
                          ])
                        : CircleAvatar(
                            radius: getProportionateScreenWidth(35),
                            backgroundImage: FileImage(File(
                                context.read<UserCubit>().profilePic!.path)),
                          ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildFNameTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildLNameTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildEmailTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildAddressTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildPhoneTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    buildPasswordTextFormField(context),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    DropdownButtonFormField<String>(
                      onChanged: (String? newValue) {},
                      items: <String>["Yes", "No"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          IconBroken.Work,
                          size: 28,
                          color: AppColors.primary,
                        ),
                        fillColor: const Color(0xFFF9FAFC),
                        filled: true,
                        enabledBorder: outlineInputBorder(),
                        focusedBorder: outlineInputBorder(),
                        border: outlineInputBorder(),
                        hintText: "Are you a doctor?",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Row(
                      children: [
                        Checkbox(
                          value: context.read<UserCubit>().registerAgree,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            context
                                .read<UserCubit>()
                                .toggleRegisterAgree(value!);
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(8)),
                        Expanded(
                          child: RichText(
                              text: TextSpan(
                            text: 'I agree to the ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return const Privacy();
                                        });
                                  },
                                  child: const Text(
                                    'Terms of Service',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    KeyboardUtil.hideKeyboard(context);
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return const Privacy();
                                        });
                                  },
                                  child: const Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    (state is SignUpLoading)
                        ? const CircularProgressIndicator()
                        : DefaultButton(
                            text: 'Sign Up',
                            press: () {
                              if (context
                                  .read<UserCubit>()
                                  .registerFormKey
                                  .currentState!
                                  .validate()) {
                                context.read<UserCubit>().signUp();
                              }
                            },
                          ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.routeName);
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(
                                fontSize: 18, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField buildPhoneTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerPhoneController,
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
        hintText: "Phone Number",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildAddressTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerAddressController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kAddressNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Location,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Governorate",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildLNameTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerLNameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.User,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Last Name",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildFNameTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerFNameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kNameNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Profile,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "First Name",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildEmailTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerEmailController,
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
        hintText: "Email Address",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  TextFormField buildPasswordTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerPasswordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: context.read<UserCubit>().registerVisiblePass ? false : true,
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
            context.read<UserCubit>().toggleRegisterVisiblePass();
          },
          icon: context.read<UserCubit>().registerVisiblePass
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

  TextFormField buildConfirmPasswordTextFormField(BuildContext context) {
    return TextFormField(
      controller: context.read<UserCubit>().registerConfirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText:
          context.read<UserCubit>().registerVisibleConfirmPass ? false : true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value !=
            context.read<UserCubit>().registerPasswordController.text) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          IconBroken.Lock,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Confirm Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
        suffixIcon: IconButton(
          onPressed: () {
            context.read<UserCubit>().toggleVisibleConfirmPass();
          },
          icon: context.read<UserCubit>().registerVisibleConfirmPass
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
