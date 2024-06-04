import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skinca/core/constants/constants.dart';
import 'package:skinca/views/auth/forget_password/create_new_password.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/icon_borken.dart';

class VerificationCode extends StatelessWidget {
  VerificationCode({super.key});
  static const String routeName = '/verification_code';
  final TextEditingController phoneController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter the verification code",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "We have sent a verification code to your email or your phone number",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const OTPTextFields(),
              const SizedBox(
                height: 20,
              ),
              DefaultButton(
                text: 'Verfiy',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, CreateNewPassword.routeName);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Didn\'t receive the code? ',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
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
          IconBroken.Password,
          size: 28,
          color: AppColors.primary,
        ),
        fillColor: const Color(0xFFF9FAFC),
        filled: true,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        hintText: "Enter Verification Code",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class OTPTextFields extends StatelessWidget {
  const OTPTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.primary,
        inputDecorationTheme: otpInputDecorationTheme
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 68,
            height: 68,
            child: TextFormField(
              onChanged: (v) {
                if (v.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 68,
            height: 68,
            child: TextFormField(
              
              onChanged: (v) {
                if (v.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 68,
            height: 68,
            child: TextFormField(
              onChanged: (v) {
                if (v.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: 68,
            height: 68,
            child: TextFormField(
              onChanged: (v) {
                if (v.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
