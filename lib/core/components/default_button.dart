import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_colors.dart';


import '../constants/app_defaults.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.isSignUp = false,
    required this.text,
    required this.press,
  });
  final String? text;
  final Function()? press;
  final borderSide = const BorderSide(color: AppColors.primary, width: 2);
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: isSignUp ? borderSide : BorderSide.none,
        ),
        onPressed: press,
        color: isSignUp ? kWhiteColor : AppColors.primary,
        child: Text(
          text!,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              color: isSignUp ? AppColors.primary : kWhiteColor),
        ),
      ),
    );
  }
}
