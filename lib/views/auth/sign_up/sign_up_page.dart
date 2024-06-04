import 'package:flutter/material.dart';
import 'package:skinca/core/utils/keyboard.dart';
import 'package:skinca/views/auth/login_page.dart';

import '../../../core/components/default_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/icon_borken.dart';
import 'privacy.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String routeName = '/sign_up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fNameController = TextEditingController();

  final TextEditingController lNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool visiblePass = false;
  bool visibleConfirmPass = false;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildFNameTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildLNameTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildEmailTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildAddressTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildPhoneTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildPasswordTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  buildConfirmPasswordTextFormField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    children: [
                      Checkbox(
                        value: agree,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
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
                  DefaultButton(
                    text: 'Sign Up',
                    press: () {
                      if (_formKey.currentState!.validate()) {}
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
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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

  TextFormField buildAddressTextFormField() {
    return TextFormField(
      controller: addressController,
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

  TextFormField buildLNameTextFormField() {
    return TextFormField(
      controller: lNameController,
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

  TextFormField buildFNameTextFormField() {
    return TextFormField(
      controller: fNameController,
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
        hintText: "Email Address",
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
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
