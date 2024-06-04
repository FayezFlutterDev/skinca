import 'package:flutter/material.dart';

import '../constants/app_defaults.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(52),
      width: SizeConfig.screenWidth * 0.8,
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Color(0xFFBABABA), width: 2)),
        onPressed: () {},
        color: kWhiteColor,
        child: Row(
          children: [
            Image.asset(
              image,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: getProportionateScreenWidth(20),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
