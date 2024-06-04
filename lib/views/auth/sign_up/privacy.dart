import 'package:flutter/material.dart';
import 'package:skinca/core/constants/app_colors.dart';

import '../../../core/constants/app_defaults.dart';


class Privacy extends StatelessWidget {
  const Privacy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      width: SizeConfig.screenWidth * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                  text: '1. Privacy Protection: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We are committed to protecting the privacy of our users and ensuring the security and protection of their personal data with high levels of security.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            RichText(
              text: const TextSpan(
                  text: '2. Data Collection: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We collect and process your personal data for the purposes of providing you with our services and improving them.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
              text: const TextSpan(
                  text: '3. Data Sharing: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We do not share your personal data with any third party without your consent.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
              text: const TextSpan(
                  text: '4. Data Security: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We take all necessary measures to protect your personal data from unauthorized access, alteration, disclosure or destruction.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
              text: const TextSpan(
                  text: '5. Data Retention: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We retain your personal data for as long as necessary to provide you with our services and for the purposes described in this Privacy Policy.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
              text: const TextSpan(
                  text: '6. Changes to Privacy Policy: ',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'We reserve the right to modify this Privacy Policy at any time. If we make changes to this Privacy Policy, we will post the revised Privacy Policy on the Site and update the “Last Updated” date at the top of this Privacy Policy.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
                text: const TextSpan(
                    text: '7. No Payment Data Storage:',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                    children: [
                  TextSpan(
                    text:
                        'We secure payment transactions and avoid storing credit card details or any related financial information.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ])),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
                text: const TextSpan(
                    text: '8. Notifications and Updates: ',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                    children: [
                  TextSpan(
                    text:
                        'We will notify users of any changes to privacy or security policies through appropriate notifications and updates.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ])),
            SizedBox(height: getProportionateScreenHeight(20)),
            RichText(
                text: const TextSpan(
                    text: '9. Contact Us: ',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                    children: [
                  TextSpan(
                    text:
                        'If you have any questions about this Privacy Policy, please contact us at: SkinCa@gmail.com ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
