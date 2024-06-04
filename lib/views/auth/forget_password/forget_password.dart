import 'package:flutter/material.dart';
import 'package:skinca/views/auth/forget_password/verification_code.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_defaults.dart';
import '../../../core/constants/icon_borken.dart';


class ForgetPassword extends StatefulWidget {
  static const String routeName = '/forget_password';
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isMailSelected = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.screenHeight * 0.02),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        setState(() {
                          isMailSelected = true;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          width: SizeConfig.screenWidth * 0.4,
                          height: SizeConfig.screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: isMailSelected
                                ? Colors.white
                                : const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 20,
                                color: isMailSelected
                                    ? AppColors.primary
                                    : Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMailSelected = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: SizeConfig.screenWidth * 0.4,
                        height: SizeConfig.screenHeight * 0.07,
                        decoration: BoxDecoration(
                          color: isMailSelected
                              ? const Color(0xFFE5E7EB)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  isMailSelected ? Colors.grey : AppColors.primary,
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
              isMailSelected
                  ? buildEmailTextFormField()
                  : buildPhoneTextFormField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              DefaultButton(
                  text: 'Reset Password',
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      if (isMailSelected) {
                         Navigator.pushNamed(
                            context, VerificationCode.routeName);
                      } else {
                        Navigator.pushNamed(
                            context, VerificationCode.routeName);
                      }
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      controller: emailController,
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

  TextFormField buildPhoneTextFormField() {
    return TextFormField(
      controller: phoneController,
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
