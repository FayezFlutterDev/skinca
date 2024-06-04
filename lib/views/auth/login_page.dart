import 'package:flutter/material.dart';
import 'package:skinca/core/components/default_button.dart';
import 'package:skinca/core/constants/app_colors.dart';
import 'package:skinca/views/auth/forget_password/forget_password.dart';
import 'package:skinca/views/auth/sign_up/sign_up_page.dart';
import 'package:skinca/views/home/home.dart';
import '../../core/components/divider.dart';
import '../../core/components/social_card.dart';
import '../../core/components/verified_dialog.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/icon_borken.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool visiblePass = false;
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildEmailTextFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildPasswordTextFormField(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
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
                  DefaultButton(
                      text: "Login",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          
                          showGeneralDialog(
                            barrierLabel: 'Dialog',
                            barrierDismissible: true,
                            context: context,
                            pageBuilder: (ctx, anim1, anim2) => VerifiedDialog(
                              text: 'Yeay! 🎉\n Welcome Back',
                              text2: 'You have logged in successfully',
                              text3: 'Go to Home',
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomePage.routeName, (route) => false);
                              },
                            ),
                            transitionBuilder: (ctx, anim1, anim2, child) =>
                                ScaleTransition(
                              scale: anim1,
                              child: child,
                            ),
                          );
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
                      style: TextStyle(fontSize: 18, color: AppColors.primary),
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
}
