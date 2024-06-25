import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_colors.dart';
import 'package:skinca/views/auth/login/login_page.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/icon_borken.dart';
import '../../../core/components/verified_dialog.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});
  static const String routeName = '/create_new_password';

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool visiblePass = false;
  bool visibleConfirmPass = false;

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create a new password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              const Text(
                "Your new password must be different from previous used passwords",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              buildPasswordTextFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              buildConfirmPasswordTextFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              DefaultButton(
                text: 'Create Password',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    showGeneralDialog(
                      barrierLabel: 'Dialog',
                      barrierDismissible: true,
                      context: context,
                      pageBuilder: (ctx, anim1, anim2) =>
                           VerifiedDialog(
                            text: 'Success!',
                            text2: 'Your password has been changed successfully',
                            text3: 'Login',
                            onPressed: (){
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                          ),
                      transitionBuilder: (ctx, anim1, anim2, child) =>
                          ScaleTransition(
                        scale: anim1,
                        child: child,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: visiblePass ? false : true,
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
            setState(() {
              visiblePass = !visiblePass;
            });
          },
          icon: visiblePass
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

  TextFormField buildConfirmPasswordTextFormField() {
    return TextFormField(
      controller: confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: visibleConfirmPass ? false : true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value != passwordController.text) {
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
            setState(() {
              visibleConfirmPass = !visibleConfirmPass;
            });
          },
          icon: visibleConfirmPass
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
